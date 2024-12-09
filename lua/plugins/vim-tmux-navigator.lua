return {
  "christoomey/vim-tmux-navigator",
  vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { noremap = true, silent = true }),
}
