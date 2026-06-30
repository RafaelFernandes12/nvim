-- Helper for opening git tools (Diffview, Neogit) from a folder that may itself
-- be a repo, or may be a parent containing several repos.
--
--   * cwd has MORE THAN ONE git sub-repo  -> prompt to pick one, then call
--     `on_choice(<absolute path to chosen repo>)`.
--   * otherwise                            -> normal flow, call `on_choice(nil)`
--     so the caller operates on the cwd as usual.
local M = {}

local function git_subrepos(root)
  return vim.fn.readdir(root, function(name)
    return vim.fn.isdirectory(root .. "/" .. name .. "/.git") == 1
  end)
end

---@param on_choice fun(path: string|nil)
function M.pick(on_choice)
  local root = vim.fn.getcwd()
  local repos = git_subrepos(root)
  if #repos > 1 then
    vim.ui.select(repos, { prompt = "Pick repo:" }, function(choice)
      if choice then
        on_choice(root .. "/" .. choice)
      end
    end)
  else
    on_choice(nil)
  end
end

return M
