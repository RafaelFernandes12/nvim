local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<A-j>", ":m .+1<CR>==", vim.tbl_extend("force", opts, { desc = "move line down" }))
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "move selected lines down" }))
keymap("n", "<A-k>", ":m .-2<CR>==", vim.tbl_extend("force", opts, { desc = "move line up" }))
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "move selected lines up" }))

keymap("n", "<leader>s", ":w<CR>", vim.tbl_extend("force", opts, { desc = "save" }))
keymap("n", "<leader>q", ":q!<CR>", vim.tbl_extend("force", opts, { desc = "quit" }))

keymap("n", "<C-a>", "GVgg", vim.tbl_extend("force", opts, { desc = "select all" }))
-- Window management keymaps
keymap("n", "<leader>w-", ":split<CR>", vim.tbl_extend("force", opts, { desc = "Split window horizontally" }))
keymap("n", "<leader>wq", ":vsplit<CR>", vim.tbl_extend("force", opts, { desc = "Split window vertically" }))
keymap("n", "<leader>w=", "<C-w>=", vim.tbl_extend("force", opts, { desc = "Equalize window sizes" }))
keymap("n", "<C-Right>", ":vertical resize -2<CR>", vim.tbl_extend("force", opts, { desc = "Decrease window width" }))
keymap("n", "<C-left>", ":vertical resize +2<CR>", vim.tbl_extend("force", opts, { desc = "Increase window width" }))
keymap("n", "<C-Up>", ":resize +2<CR>", vim.tbl_extend("force", opts, { desc = "Increase window height" }))
keymap("n", "<C-Down>", ":resize -2<CR>", vim.tbl_extend("force", opts, { desc = "Decrease window height" }))

-- find and replace keymaps
vim.keymap.set("n", "<leader>rw", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Replace word under cursor" })
vim.keymap.set("n", "<leader>rc", ":%s/<C-r><C-w>//gc<Left><Left>", { desc = "Replace word under cursor confirmation" })

keymap("n", "<leader>lI", ":LspInfo<CR>", vim.tbl_extend("force", opts, { desc = "lspInfo" }))
keymap({ "n", "o", "x" }, "L", "$", { noremap = true, silent = true })
keymap({ "n", "o", "x" }, "H", "0", vim.tbl_extend("force", opts, { desc = "start of the line" }))
keymap("n", "<leader>ct", function()
  vim.fn.system("cat ~/source/token | wl-copy") -- For Linux
end, { desc = "Copy token to clipboard" })
keymap("n", "<leader>ck", function()
  vim.fn.system("cat ~/source/key | wl-copy") -- For Linux
end, { desc = "Copy apiKey to clipboard" })
keymap("n", "<leader>l", ":cprev<CR>", vim.tbl_extend("force", opts, { desc = "previous instance of quick fix list" }))
keymap("n", "<leader>ç", ":cnext<CR>", vim.tbl_extend("force", opts, { desc = "next instance of quick fix list" }))
keymap("n", "<leader>no", ":noh<CR>", vim.tbl_extend("force", opts, { desc = "clean highlight" }))

vim.keymap.set("x", "p", [["_dP]], { noremap = true, silent = true })

vim.keymap.set("n", "<leader>m", ":messages<CR>", { noremap = true, silent = true, desc = "messages" }) -- Toggle fold under cursor

function definition_split_vertical()
  vim.lsp.buf.definition({
    on_list = function(options)
      -- if there are multiple items, warn the user
      if #options.items > 1 then
        vim.notify("Multiple items found, opening first one", vim.log.levels.WARN)
      end

      -- Open the first item in a vertical split
      local item = options.items[1]
      local cmd = "vsplit +" .. item.lnum .. " " .. item.filename .. "|" .. "normal " .. item.col .. "|"

      vim.cmd(cmd)
    end,
  })
end

function definition_split_horizontal()
  vim.lsp.buf.definition({
    on_list = function(options)
      -- if there are multiple items, warn the user
      if #options.items > 1 then
        vim.notify("Multiple items found, opening first one", vim.log.levels.WARN)
      end

      -- Open the first item in a vertical split
      local item = options.items[1]
      local cmd = "split +" .. item.lnum .. " " .. item.filename .. "|" .. "normal " .. item.col .. "|"

      vim.cmd(cmd)
    end,
  })
end

vim.keymap.set('n', '<leader>lD', '<cmd>lua definition_split_vertical()<CR>',
  { desc = "Go to definition in right panel" })
vim.keymap.set('n', '<leader>lR', '<cmd>lua definition_split_horizontal()<CR>',
  { desc = "Go to definition in right panel" })

-- Keymap to build the project and then run the compiled JS file
keymap("n", "<leader>rr", function()
  local current_full_path = vim.fn.expand('%:p')
  local project_root = vim.fn.getcwd()
  local relative_path_from_src = string.gsub(current_full_path, "^" .. project_root .. "/src/", "")
  print(relative_path_from_src)
  local compiled_js_relative_path = string.gsub(relative_path_from_src, "%.ts$", ".js")
  local compiled_js_full_path = project_root .. "/dist/" .. compiled_js_relative_path

  local cmd = "yarn build && node " .. compiled_js_full_path
  vim.cmd("TermExec cmd='" .. cmd .. "'")
end, { desc = "Build & Run TS file" })

local float_http_buf = nil


vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close current tab' })
vim.keymap.set('n', '<leader>tt', ':tabnew<CR>', { desc = 'Close current tab' })

vim.keymap.set('n', '<leader>cll', function()
  local word = vim.fn.expand("<cword>")
  local log = "console.log('" .. word:upper() .. "', " .. word .. ");"
  vim.fn.setreg('+', log)
  print("Copied to clipboard: " .. log)
end, { desc = "Copy console.log of word under cursor" })

vim.keymap.set('n', '<leader>clo', function()
  local word = vim.fn.expand("<cword>")
  local cap_word = word:sub(1, 1):upper() .. word:sub(2)
  local log = "console.log('" .. word:upper() .. "', " .. word .. ");"
  vim.api.nvim_put({ log }, 'l', true, true)
  print("Inserted below: " .. log)
end, { desc = "Insert console.log of word under cursor below" })
