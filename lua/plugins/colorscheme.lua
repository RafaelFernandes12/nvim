return {
  {
    -- "folke/tokyonight.nvim",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    -- 	vim.cmd.colorscheme("tokyonight-night")
    -- end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    -- "rose-pine/neovim",
    -- name = "rose-pine",
    -- config = function()
    -- 	vim.cmd("colorscheme rose-pine-moon")
    -- end,
  },
  {
    -- "bluz71/vim-moonfly-colors",
    -- name = "moonfly",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    -- 	vim.cmd.colorscheme("moonfly")
    -- end,
  },
  {
    -- "ellisonleao/gruvbox.nvim",
    -- priority = 1000,
    -- config = function()
    -- 	vim.o.background = "dark" -- or "light" for light mode
    -- 	vim.cmd([[colorscheme gruvbox]])
    -- end,
    -- opts = ...,
  },
}
