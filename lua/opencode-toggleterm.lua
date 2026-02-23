local M = {}

---@class OpencodeToggletermOpts
---@field cmd? string
---@field attach_cmd? string
---@field port? number
---@field term_id? number
---@field direction? string
---@field auto_reload? boolean
---@field float_opts? table
---@field select_last_session? boolean
---@field select_delay_ms? number
---@field select_retry_limit? number
---@field select_retry_delay_ms? number
---@field attach_any_running? boolean
---@field cleanup_attach? boolean
---@field cleanup_on_exit? boolean
---@field run_opencode? boolean
---@field retry_limit? number
---@field retry_delay_ms? number

local defaults = {
  cmd = nil,
  attach_cmd = nil,
  port = 4242,
  term_id = 2,
  direction = "float",
  auto_reload = true,
  float_opts = {
    width = math.floor(vim.o.columns * 1),
    height = math.floor(vim.o.lines * 1),
  },
  select_last_session = true,
  select_delay_ms = 700,
  select_retry_limit = 10,
  select_retry_delay_ms = 800,
  attach_any_running = true,
  cleanup_attach = true,
  cleanup_on_exit = true,
  run_opencode = false,
  retry_limit = 6,
  retry_delay_ms = 1000,
}

local state = {
  opts = nil,
  term = nil,
  port = nil,
  sse_job_id = nil,
  retry_timer = nil,
  retry_count = 0,
  select_timer = nil,
  select_retry_count = 0,
  select_pending = false,
  select_once_done = false,
  active = false,
  warned_no_curl = false,
}

---@param cmd string
---@return number|nil
local function parse_port(cmd)
  local port = cmd:match("%-%-port%s+(%d+)")
  return port and tonumber(port) or nil
end

---@param opts OpencodeToggletermOpts
---@return string, number
local function build_start_cmd(opts)
  local cmd = opts.cmd or "opencode"
  local port = opts.port or defaults.port
  local port_from_cmd = parse_port(cmd)
  if port_from_cmd then
    port = port_from_cmd
  end

  cmd = cmd:gsub("%-%-port%s+%d+", "")
  cmd = cmd:gsub("%-%-port", "")
  cmd = cmd:gsub("%s+", " ")
  cmd = cmd:gsub("^%s+", "")
  cmd = cmd:gsub("%s+$", "")
  cmd = cmd .. " --port " .. port

  return cmd, port
end

---@param opts OpencodeToggletermOpts
---@param port number
---@return string
local function build_attach_cmd(opts, port)
  local cmd = opts.attach_cmd or "opencode attach"
  cmd = cmd:gsub("%s+$", "")
  return cmd .. " http://localhost:" .. port
end

---@param cmd string[]
---@return { code: number, stdout: string }
local function system_call(cmd)
  if vim.system then
    local result = vim.system(cmd, { text = true }):wait()
    return { code = result.code or 1, stdout = result.stdout or "" }
  end

  local output = vim.fn.system(cmd)
  return { code = vim.v.shell_error, stdout = output or "" }
end

---@param port number
---@return boolean
local function is_server_running(port)
  if not port then
    return false
  end
  if vim.fn.executable("curl") ~= 1 then
    return false
  end

  local result = system_call({ "curl", "-s", "--connect-timeout", "1", "http://localhost:" .. port .. "/path" })
  if result.code ~= 0 or result.stdout == "" then
    return false
  end

  local ok = pcall(vim.fn.json_decode, result.stdout)
  return ok
end

local function normalize_path(path)
  if not path then
    return nil
  end
  if vim.fn.has("win32") == 1 then
    return path:gsub("/", "\\")
  end
  return path
end

---@return number[]
local function get_running_ports_unix()
  local result = system_call({ "pgrep", "-f", "opencode.*--port" })
  if result.code ~= 0 or result.stdout == "" then
    return {}
  end

  local ports = {}
  local seen = {}
  for pid in result.stdout:gmatch("[^\r\n]+") do
    local lsof = system_call({
      "lsof",
      "-w",
      "-iTCP",
      "-sTCP:LISTEN",
      "-P",
      "-n",
      "-a",
      "-p",
      pid,
    })
    if lsof.code == 0 and lsof.stdout ~= "" then
      for line in lsof.stdout:gmatch("[^\r\n]+") do
        if not line:match("^COMMAND") then
          local port = line:match(":(%d+)$")
          if port and not seen[port] then
            seen[port] = true
            table.insert(ports, tonumber(port))
          end
        end
      end
    end
  end

  return ports
end

---@return number[]
local function get_running_ports()
  if vim.fn.has("win32") == 1 then
    return {}
  end
  return get_running_ports_unix()
end

---@param port number
---@return string|nil
local function get_server_cwd(port)
  if vim.fn.executable("curl") ~= 1 then
    return nil
  end

  local result = system_call({
    "curl",
    "-s",
    "--connect-timeout",
    "1",
    "http://localhost:" .. port .. "/path",
  })
  if result.code ~= 0 or result.stdout == "" then
    return nil
  end

  local ok, payload = pcall(vim.fn.json_decode, result.stdout)
  if not ok or type(payload) ~= "table" then
    return nil
  end

  return payload.directory or payload.worktree
end

---@param opts OpencodeToggletermOpts
---@return number|nil
local function find_running_port(opts)
  local preferred_port = opts.port or defaults.port
  if is_server_running(preferred_port) then
    return preferred_port
  end

  local ports = get_running_ports()
  if #ports == 0 then
    return nil
  end

  local cwd = normalize_path(vim.fn.getcwd())
  local fallback = nil
  for _, port in ipairs(ports) do
    fallback = fallback or port
    local server_cwd = normalize_path(get_server_cwd(port))
    if server_cwd and cwd and server_cwd == cwd then
      return port
    end
  end

  if opts.attach_any_running then
    return fallback
  end

  return nil
end

---@param opts OpencodeToggletermOpts
---@return string, number
local function resolve_cmd(opts)
  local start_cmd, port = build_start_cmd(opts)
  local running_port = find_running_port(opts)
  if running_port then
    return build_attach_cmd(opts, running_port), running_port, true
  end
  return start_cmd, port, false
end

local function has_curl()
  if vim.fn.executable("curl") == 1 then
    return true
  end
  if not state.warned_no_curl then
    state.warned_no_curl = true
    vim.notify("curl not found; opencode integration disabled", vim.log.levels.WARN)
  end
  return false
end

---@param port number
local function cleanup_attach_processes(port)
  if vim.fn.has("win32") == 1 then
    return
  end
  if vim.fn.executable("pkill") ~= 1 then
    return
  end
  if not port then
    return
  end

  local pattern = "opencode attach http://localhost:" .. port
  system_call({ "pkill", "-f", pattern })
end

local function ensure_autoread()
  if not vim.o.autoread then
    vim.o.autoread = true
  end
end

local function reload_buffers()
  if not state.opts.auto_reload then
    return
  end
  ensure_autoread()
  vim.schedule(function()
    vim.cmd("checktime")
  end)
end

---@param event table
local function handle_event(event)
  if event.type == "file.edited" then
    state.retry_count = 0
    reload_buffers()
  end
end

local function stop_sse()
  if state.sse_job_id then
    vim.fn.jobstop(state.sse_job_id)
    state.sse_job_id = nil
  end
  if state.retry_timer then
    state.retry_timer:stop()
    state.retry_timer:close()
    state.retry_timer = nil
  end
  state.retry_count = 0
end

local function stop_select()
  if state.select_timer then
    state.select_timer:stop()
    state.select_timer:close()
    state.select_timer = nil
  end
  state.select_retry_count = 0
  state.select_pending = false
end

local function fetch_last_session_id(port)
  if not has_curl() then
    return nil
  end

  local result = system_call({
    "curl",
    "-s",
    "--connect-timeout",
    "1",
    "-H",
    "Accept: application/json",
    "http://localhost:" .. port .. "/session",
  })

  if result.code ~= 0 or result.stdout == "" then
    return nil
  end

  local ok, sessions = pcall(vim.fn.json_decode, result.stdout)
  if not ok or type(sessions) ~= "table" then
    return nil
  end

  local session = sessions[1]
  if not session or not session.id then
    return nil
  end

  return session.id
end

local function select_session(port, session_id)
  if not has_curl() then
    return false
  end

  local body = vim.fn.json_encode({ sessionID = session_id })
  local result = system_call({
    "curl",
    "-s",
    "--connect-timeout",
    "1",
    "-X",
    "POST",
    "-H",
    "Content-Type: application/json",
    "-d",
    body,
    "http://localhost:" .. port .. "/tui/select-session",
  })

  return result.code == 0
end

local function try_select_last_session()
  if not state.port or not state.opts.select_last_session then
    return false
  end

  local session_id = fetch_last_session_id(state.port)
  if not session_id then
    return false
  end

  return select_session(state.port, session_id)
end

local select_once_attempt

local function schedule_select_retry()
  if not state.select_pending or not state.opts.select_last_session then
    return
  end
  if state.select_retry_count >= state.opts.select_retry_limit then
    state.select_once_done = true
    stop_select()
    return
  end

  state.select_retry_count = state.select_retry_count + 1
  if not state.select_timer then
    state.select_timer = vim.uv.new_timer()
  end

  state.select_timer:stop()
  state.select_timer:start(state.opts.select_retry_delay_ms, 0, vim.schedule_wrap(function()
    if select_once_attempt() then
      state.select_retry_count = 0
    else
      schedule_select_retry()
    end
  end))
end

select_once_attempt = function()
  if state.select_once_done or not state.select_pending or not state.opts.select_last_session then
    return true
  end

  if not state.port then
    return false
  end

  if not has_curl() then
    state.select_once_done = true
    stop_select()
    return true
  end

  if not is_server_running(state.port) then
    return false
  end

  if try_select_last_session() then
    state.select_once_done = true
    stop_select()
    return true
  end

  return false
end

local start_sse

local function schedule_retry()
  if not state.active then
    return
  end
  if state.retry_count >= state.opts.retry_limit then
    return
  end

  state.retry_count = state.retry_count + 1
  if not state.retry_timer then
    state.retry_timer = vim.uv.new_timer()
  end

  state.retry_timer:stop()
  state.retry_timer:start(state.opts.retry_delay_ms, 0, vim.schedule_wrap(function()
    start_sse()
  end))
end

start_sse = function()
  if state.sse_job_id or not state.port or not state.active then
    return
  end

  if not has_curl() then
    return
  end

  local response_buffer = {}
  local function flush_buffer()
    if #response_buffer == 0 then
      return
    end
    local payload = table.concat(response_buffer)
    response_buffer = {}
    if payload == "" then
      return
    end
    vim.schedule(function()
      local ok, event = pcall(vim.fn.json_decode, payload)
      if ok and type(event) == "table" then
        handle_event(event)
      end
    end)
  end

  local command = {
    "curl",
    "-s",
    "--connect-timeout",
    "1",
    "-H",
    "Accept: text/event-stream",
    "-N",
    "http://localhost:" .. state.port .. "/event",
  }

  state.sse_job_id = vim.fn.jobstart(command, {
    on_stdout = function(_, data)
      if not data then
        return
      end
      for _, line in ipairs(data) do
        if line == "" then
          flush_buffer()
        else
          local clean = line:gsub("^data:%s*", "")
          table.insert(response_buffer, clean)
        end
      end
    end,
    on_exit = function(_, code)
      state.sse_job_id = nil
      if code == 0 or code == 18 or code == 143 then
        return
      end
      schedule_retry()
    end,
  })

  if state.sse_job_id <= 0 then
    state.sse_job_id = nil
    schedule_retry()
  end
end

---@param opts? OpencodeToggletermOpts
function M.setup(opts)
  local user_opts = type(vim.g.opencode_toggleterm) == "table" and vim.g.opencode_toggleterm or {}
  state.opts = vim.tbl_deep_extend("force", defaults, user_opts, opts or {})

  local Terminal = require("toggleterm.terminal").Terminal
  state.term = Terminal:new({
    id = state.opts.term_id,
    direction = state.opts.direction,
    float_opts = state.opts.float_opts,
    on_open = function()
      state.active = true
      if state.opts.auto_reload and state.opts.run_opencode then
        ensure_autoread()
        vim.defer_fn(start_sse, 800)
      end
      if state.opts.run_opencode and state.opts.select_last_session and not state.select_once_done and not state.select_pending then
        state.select_pending = true
        state.select_retry_count = 0
        vim.defer_fn(function()
          if not select_once_attempt() then
            schedule_select_retry()
          end
        end, state.opts.select_delay_ms)
      end
    end,
    on_exit = function(_, _, exit_code)
      state.active = false
      stop_sse()
      if exit_code and exit_code ~= 0 then
        vim.notify("opencode exited (" .. exit_code .. ")", vim.log.levels.WARN)
      end
    end,
  })

  M.term = state.term
  M.toggle = function()
    if not state.term:is_open() then
      if state.opts.run_opencode then
        local cmd, port, is_attach = resolve_cmd(state.opts)
        if is_attach and state.opts.cleanup_attach then
          cleanup_attach_processes(port)
        end
        state.term.cmd = cmd
        state.port = port
      else
        state.term.cmd = nil
        state.port = nil
      end
    end
    state.term:toggle()
  end

  if state.opts.run_opencode and state.opts.cleanup_on_exit then
    local group = vim.api.nvim_create_augroup("OpencodeToggleterm", { clear = true })
    vim.api.nvim_create_autocmd("VimLeavePre", {
      group = group,
      callback = function()
        if state.term and state.term.job_id then
          vim.fn.jobstop(state.term.job_id)
        end
        if state.port and state.opts.cleanup_attach then
          cleanup_attach_processes(state.port)
        end
      end,
      desc = "Stop opencode attach on exit",
    })
  end

  return M
end

return M
