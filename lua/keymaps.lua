local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<A-j>", ":m .+1<CR>==", vim.tbl_extend("force", opts, { desc = "move line down" }))
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "move selected lines down" }))
keymap("n", "<A-k>", ":m .-2<CR>==", vim.tbl_extend("force", opts, { desc = "move line up" }))
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "move selected lines up" }))

keymap("n", "<leader>ss", ":w<CR>", vim.tbl_extend("force", opts, { desc = "save and format" }))
keymap("n", "<leader>sa", ":wa<CR>", vim.tbl_extend("force", opts, { desc = "save all" }))
keymap("n", "<leader>q", ":q!<CR>", vim.tbl_extend("force", opts, { desc = "quit" }))
keymap("n", "<C-a>", "GVgg", vim.tbl_extend("force", opts, { desc = "select all" }))
-- Window management keymaps
keymap("n", "<leader>w-", ":split<CR>", vim.tbl_extend("force", opts, { desc = "Split window horizontally" }))
keymap("n", "<leader>w/", ":vsplit<CR>", vim.tbl_extend("force", opts, { desc = "Split window vertically" }))
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

vim.keymap.set("n", "<leader>m", ":messages<CR>", { noremap = true, silent = true, desc = "messages" }) -- Toggle fold under cursor
keymap(
  "n",
  "<leader>cl",
  "oconsole.log('aqui');<Esc>:w<CR>",
  vim.tbl_extend("force", opts, { desc = "console.log('aqui')" })
)
