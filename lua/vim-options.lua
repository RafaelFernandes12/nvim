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
	vim.lsp.buf.execute_command({
		command = "vtsls.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	})
end, { desc = "save, format and organize the imports" })
keymap("n", "<leader>sa", ":wa<CR>", { desc = "write all" })
keymap("n", "<leader>qq", ":close<CR>", { desc = "exit" })
keymap("n", "<leader>qa", ":q!<CR>", { desc = "exit vim" })
keymap("n", "<C-a>", "GVgg", { desc = "select the whole file" })

-- Window management keymaps
keymap("n", "<leader>w-", ":split<CR>", vim.tbl_extend("force", opts, { desc = "Split window horizontally" }))
keymap("n", "<leader>w\\", ":vsplit<CR>", vim.tbl_extend("force", opts, { desc = "Split window vertically" }))
keymap("n", "<leader>w=", "<C-w>=", vim.tbl_extend("force", opts, { desc = "Equalize window sizes" }))

-- Terminal keymap
keymap("n", "<leader>t", ":split | terminal<CR>", vim.tbl_extend("force", opts, { desc = "Open a terminal below" }))
keymap("t", "<Esc>", [[<C-\><C-n>]], vim.tbl_extend("force", opts, { desc = "Exit terminal mode to normal mode" }))

-- find and replace keymaps
vim.keymap.set("n", "<leader>rw", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Replace word under cursor" })
vim.keymap.set("n", "<leader>rc", ":%s/<C-r><C-w>//gc<Left><Left>", { desc = "Replace word under cursor confirmation" })
