local custom_highlights = {
  Normal = { bg = "#000000" },       -- Main buffer
  NormalNC = { bg = "#000000" },     -- Non-current buffer
  NormalFloat = { bg = "#000000" },  -- Floating windows
  FloatBorder = { bg = "#000000" },  -- Floating window borders
  SignColumn = { bg = "#000000" },   -- Sign column (e.g., diagnostics)
  LineNr = { bg = "#000000" },       -- Line numbers
  EndOfBuffer = { bg = "#000000" },  -- Background after the end of buffer
  WinSeparator = { bg = "#000000" }, -- Window separators
}

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
  {
    -- "rebelot/kanagawa.nvim",
    -- priority = 1000,
    -- config = function()
    --   vim.cmd("colorscheme kanagawa-dragon")
    -- end
  },
  {
    -- "catppuccin/nvim",
    -- lazy = false,
    -- name = "catppuccin",
    -- priority = 1000,
    -- config = function()
    --   require("catppuccin").setup({
    --     flavour = "mocha", -- Choose the variant
    --     -- custom_highlights = custom_highlights,
    --   })
    --   vim.cmd.colorscheme("catppuccin")
    -- end,
  },
  {
    -- "rose-pine/neovim",
    -- name = "rose-pine",
    -- config = function()
    --   require("rose-pine").setup({
    --     -- variant = "moon",
    --     -- palette = {
    --     --   moon = {
    --     --     base = "#000000",
    --     --   },
    --     -- },
    --   })
    --   -- vim.cmd("colorscheme rose-pine-moon")
    --   vim.cmd("colorscheme rose-pine")
    --   -- vim.api.nvim_set_hl(0, "TelescopeBorder", { --[[ fg = "#000000", ]]
    --   --   bg = "#000000",
    --   -- })
    --   -- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#000000" })
    --   -- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#000000" })
    --   -- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "#000000" })
    --   -- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#000000" })
    --   --
    --   -- -- Override highlight groups for markdown code blocks
    --   -- vim.api.nvim_set_hl(0, "RenderMarkdownBackground", { bg = "#000000" })
    --   -- vim.api.nvim_set_hl(0, "RenderMarkdownCodeBlock", { bg = "#000000", fg = "#ffffff" })
    --   -- vim.api.nvim_set_hl(0, "RenderMarkdownInlineCode", { bg = "#000000", fg = "#ffffff" })
    -- end,
  },
  {
    -- "bluz71/vim-moonfly-colors",
    -- name = "moonfly",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme("moonfly")
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
