vim.g.mapleader = " "

-- vim.opt.termguicolors = true

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.number = true
vim.opt.relativenumber = true

vim.g.tmux_navigator_no_mappings = 1
vim.opt.splitbelow = true
vim.opt.splitright = true

-- vim.g.clipboard = {
--   name = "wl-clipboard",
--   copy = {
--     ["+"] = "wl-copy",
--     ["*"] = "wl-copy"
--   },
--   paste = {
--     ["+"] = "wl-paste --no-newline",
--     ["*"] = "wl-paste --no-newline"
--   },
--   cache_enabled = 1
-- }

vim.opt.clipboard = "unnamedplus"

vim.o.wrap = false
vim.o.hidden = true

vim.opt.scrolloff = 999

vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- vim.opt.spell = true
-- vim.opt.spelllang = "en,pt"
