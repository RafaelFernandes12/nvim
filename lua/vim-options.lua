vim.g.mapleader = " "
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

vim.opt.termguicolors = true

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.clipboard = "unnamedplus"

vim.o.wrap = false

vim.opt.scrolloff = 999
keymap("n", "<A-j>", ":m .+1<CR>==", { desc = "move line down" })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move selected lines down" })
keymap("n", "<A-k>", ":m .-2<CR>==", { desc = "move line up" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move selected lines up" })

keymap("n", "<leader>ss", function()
	vim.cmd("write")
	vim.lsp.buf.format({ async = false })
end, { desc = "save, format and organize the imports" })
keymap("n", "<leader>sa", ":wa<CR>", { desc = "save all buffers" })
keymap("n", "<leader>q", ":q<CR>", vim.tbl_extend("force", opts, { desc = "quit" }))
keymap("n", "<C-a>", "GVgg", vim.tbl_extend("force", opts, { desc = "select all" }))
-- Window management keymaps
keymap("n", "<leader>w-", ":split<CR>", vim.tbl_extend("force", opts, { desc = "Split window horizontally" }))
keymap("n", "<leader>w\\", ":vsplit<CR>", vim.tbl_extend("force", opts, { desc = "Split window vertically" }))
keymap("n", "<leader>w=", "<C-w>=", vim.tbl_extend("force", opts, { desc = "Equalize window sizes" }))

-- Terminal keymap
keymap("n", "<leader>t", ":split | terminal<CR>", vim.tbl_extend("force", opts, { desc = "Open a terminal below" }))
keymap("t", "<Esc>", [[<C-\><C-n>]], vim.tbl_extend("force", opts, { desc = "Exit terminal mode to normal mode" }))

-- find and replace keymaps
-- keymap("n", "<leader>f", "/", { desc = "find" })
vim.keymap.set("n", "<leader>rw", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Replace word under cursor" })
vim.keymap.set("n", "<leader>rc", ":%s/<C-r><C-w>//gc<Left><Left>", { desc = "Replace word under cursor confirmation" })
