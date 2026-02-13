local custom_highlights = {
  Normal = { bg = "#000000" },       -- Main buffer
  NormalNC = { bg = "#000000" },     -- Non-current buffer
  NormalFloat = { bg = "#000000" },  -- Floating windows
  FloatBorder = { bg = "#000000" },  -- Floating window borders
  SignColumn = { bg = "#000000" },   -- Sign column (e.g., diagnostics)
  LineNr = { bg = "#000000" },       -- Line numbers
  CursorLine = { bg = "#000000" },   -- Current line background
  CursorLineNr = { bg = "#000000" }, -- Current line number
  ColorColumn = { bg = "#000000" },  -- Color column
  EndOfBuffer = { bg = "#000000" },  -- Background after the end of buffer
  WinSeparator = { bg = "#000000" }, -- Window separators
  MarkviewCode = { bg = "#0d0d0d" },
  MarkviewCodeBorder = { bg = "#ffffff", fg = "#000000" },
  MarkviewCodeFg = { fg = "#86b9c6" },
  MarkviewCodeInfo = { fg = "#86b9c6" },
  MarkviewInlineCode = { bg = "#000000", fg = "#86b9c6" },
  MarkviewPalette0 = { fg = "#8a8a8a", bg = "#000000" },
  MarkviewPalette0Fg = { fg = "#8a8a8a" },
  MarkviewPalette0Bg = { bg = "#000000" },
  MarkviewPalette0Sign = { fg = "#8a8a8a", bg = "#000000" },
  MarkviewPalette1 = { fg = "#d96c7b", bg = "#000000" },
  MarkviewPalette1Fg = { fg = "#d96c7b" },
  MarkviewPalette1Bg = { bg = "#000000" },
  MarkviewPalette1Sign = { fg = "#d96c7b", bg = "#000000" },
  MarkviewPalette2 = { fg = "#d8b56f", bg = "#000000" },
  MarkviewPalette2Fg = { fg = "#d8b56f" },
  MarkviewPalette2Bg = { bg = "#000000" },
  MarkviewPalette2Sign = { fg = "#d8b56f", bg = "#000000" },
  MarkviewPalette3 = { fg = "#d98f8a", bg = "#000000" },
  MarkviewPalette3Fg = { fg = "#d98f8a" },
  MarkviewPalette3Bg = { bg = "#000000" },
  MarkviewPalette3Sign = { fg = "#d98f8a", bg = "#000000" },
  MarkviewPalette4 = { fg = "#4a8aa1", bg = "#000000" },
  MarkviewPalette4Fg = { fg = "#4a8aa1" },
  MarkviewPalette4Bg = { bg = "#000000" },
  MarkviewPalette4Sign = { fg = "#4a8aa1", bg = "#000000" },
  MarkviewPalette5 = { fg = "#86b9c6", bg = "#000000" },
  MarkviewPalette5Fg = { fg = "#86b9c6" },
  MarkviewPalette5Bg = { bg = "#000000" },
  MarkviewPalette5Sign = { fg = "#86b9c6", bg = "#000000" },
  MarkviewPalette6 = { fg = "#b298d6", bg = "#000000" },
  MarkviewPalette6Fg = { fg = "#b298d6" },
  MarkviewPalette6Bg = { bg = "#000000" },
  MarkviewPalette6Sign = { fg = "#b298d6", bg = "#000000" },
  MarkviewHeading1 = { fg = "#d96c7b", bg = "#3a0f18" },
  MarkviewHeading2 = { fg = "#d8b56f", bg = "#3a2b0a" },
  MarkviewHeading3 = { fg = "#d98f8a", bg = "#3a1514" },
  MarkviewHeading4 = { fg = "#4a8aa1", bg = "#0f2b34" },
  MarkviewHeading5 = { fg = "#86b9c6", bg = "#0f2d33" },
  MarkviewHeading6 = { fg = "#b298d6", bg = "#241436" },
  MarkviewHeading1Sign = { fg = "#d96c7b", bg = "#3a0f18" },
  MarkviewHeading2Sign = { fg = "#d8b56f", bg = "#3a2b0a" },
  MarkviewHeading3Sign = { fg = "#d98f8a", bg = "#3a1514" },
  MarkviewHeading4Sign = { fg = "#4a8aa1", bg = "#0f2b34" },
  MarkviewHeading5Sign = { fg = "#86b9c6", bg = "#0f2d33" },
  MarkviewHeading6Sign = { fg = "#b298d6", bg = "#241436" },
  markdownH1 = { fg = "#d96c7b" },
  markdownH2 = { fg = "#d8b56f" },
  markdownH3 = { fg = "#d98f8a" },
  markdownH4 = { fg = "#4a8aa1" },
  markdownH5 = { fg = "#86b9c6" },
  markdownH6 = { fg = "#b298d6" },
  markdownH1Delimiter = { fg = "#d96c7b" },
  markdownH2Delimiter = { fg = "#d8b56f" },
  markdownH3Delimiter = { fg = "#d98f8a" },
  markdownH4Delimiter = { fg = "#4a8aa1" },
  markdownH5Delimiter = { fg = "#86b9c6" },
  markdownH6Delimiter = { fg = "#b298d6" },
  markdownHeadingDelimiter = { fg = "#8a8a8a" },
  markdownHeadingRule = { fg = "#8a8a8a" },
  markdownRule = { fg = "#8a8a8a" },
  ["@markup.heading"] = { bg = "#000000", fg = "#d8b56f" },
  ["@markup.heading.1"] = { bg = "#000000", fg = "#d96c7b" },
  ["@markup.heading.2"] = { fg = "#d8b56f" },
  ["@markup.heading.3"] = { fg = "#d98f8a" },
  ["@markup.heading.4"] = { fg = "#4a8aa1" },
  ["@markup.heading.5"] = { fg = "#86b9c6" },
  ["@markup.heading.6"] = { fg = "#b298d6" },
  ["@markup.heading.1.markdown"] = { fg = "#d96c7b" },
  ["@markup.heading.2.markdown"] = { fg = "#d8b56f" },
  ["@markup.heading.3.markdown"] = { fg = "#d98f8a" },
  ["@markup.heading.4.markdown"] = { fg = "#4a8aa1" },
  ["@markup.heading.5.markdown"] = { fg = "#86b9c6" },
  ["@markup.heading.6.markdown"] = { fg = "#b298d6" },
  ["@markup.hr"] = { fg = "#8a8a8a" },
  ["@markup.separator"] = { fg = "#8a8a8a" },
}

local function apply_custom_highlights()
  for group, opts in pairs(custom_highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

local function schedule_custom_highlights()
  vim.schedule(apply_custom_highlights)
end

return {
  {
    -- "folke/tokyonight.nvim",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme("tokyonight-night")
    -- end,
  },
  {
    -- "rebelot/kanagawa.nvim",
    -- priority = 1000,
    -- config = function()
    --   vim.cmd("colorscheme kanagawa-dragon")
    -- end
  },
  -- {
  --   "catppuccin/nvim",
  --   lazy = false,
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha", -- Choose the variant
  --       -- custom_highlights = custom_highlights,
  --     })
  --     vim.cmd.colorscheme("catppuccin")
  --   end,
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        palette = {
          moon = {
            _nc = "#000000",
            base = "#000000",
            surface = "#0b0b0b",
            overlay = "#121212",
            muted = "#5c5c5c",
            subtle = "#8a8a8a",
            text = "#e6e6e6",
            love = "#d96c7b",
            gold = "#d8b56f",
            rose = "#d98f8a",
            pine = "#4a8aa1",
            foam = "#86b9c6",
            iris = "#b298d6",
            leaf = "#7fa39d",
            highlight_low = "#0a0a0a",
            highlight_med = "#1a1a1a",
            highlight_high = "#2a2a2a",
            none = "NONE",
          },
        },
        highlight_groups = custom_highlights,
      })
      vim.cmd("colorscheme rose-pine")
      apply_custom_highlights()
      local highlight_group = vim.api.nvim_create_augroup("RosePineHighlights", { clear = true })
      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        group = highlight_group,
        callback = function()
          schedule_custom_highlights()
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        group = highlight_group,
        pattern = { "MarkviewEnable", "MarkviewAttach", "MarkviewHybridEnable", "MarkviewSplitviewOpen" },
        callback = function()
          schedule_custom_highlights()
        end,
      })
      --     vim.api.nvim_set_hl(0, "TelescopeBorder", { --[[ fg = "#000000", ]]
      --       bg = "#000000",
      --     })
      --     vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#000000" })
      --     vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#000000" })
      --     vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "#000000" })
      --     vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#000000" })
      --     --
      --     -- -- Override highlight groups for markdown code blocks
      --     -- vim.api.nvim_set_hl(0, "RenderMarkdownBackground", { bg = "#000000" })
      --     -- vim.api.nvim_set_hl(0, "RenderMarkdownCodeBlock", { bg = "#000000", fg = "#ffffff" })
      --     -- vim.api.nvim_set_hl(0, "RenderMarkdownInlineCode", { bg = "#000000", fg = "#ffffff" })
      --     vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#000000", fg = "#ffffff" })
      --     vim.api.nvim_set_hl(0, "CmpBorder", { bg = "#000000", fg = "#ffffff" })
      --     vim.api.nvim_set_hl(0, "CmpSel", { bg = "#222222", fg = "#ffffff" })
      --
      --     vim.api.nvim_set_hl(0, "OilNormal", { bg = "#000000", fg = "#ffffff" })
      --     vim.api.nvim_set_hl(0, "OilBorder", { bg = "#000000", fg = "#ffffff" })
      --     vim.api.nvim_set_hl(0, "OilWinBar", { bg = "#000000", fg = "#ffffff" })
      --     vim.api.nvim_set_hl(0, "CustomOilBar", { bg = "#000000", fg = "#ffffff" })
      --
      --     vim.api.nvim_set_hl(0, "KulalaNormal", { bg = "#000000" })
      --     vim.api.nvim_set_hl(0, "KulalaBorder", { bg = "#000000" })
      --     vim.api.nvim_set_hl(0, "KulalaFloat", { bg = "#000000" })
      --     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
      --     vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000" })
      --     vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
      --     vim.api.nvim_set_hl(0, "TabLine", { bg = "#000000", fg = "#ffffff" })
      --     vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#000000", fg = "#f6c177" })
      --     vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#030a1f", fg = "#ffffff" })
      --     vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#000000" })
    end,
  },
  -- {
  --   "bluz71/vim-moonfly-colors",
  --   name = "moonfly",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme("moonfly")
  --   end,
  -- },
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   config = function()
  --     vim.o.background = "dark" -- or "light" for light mode
  --     vim.cmd([[colorscheme gruvbox]])
  --   end,
  --   opts = ...,
  -- },
  --
  -- {
  --
  --   "vague-theme/vague.nvim",
  --   lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other plugins
  --   config = function()
  --     -- NOTE: you do not need to call setup if you don't want to.
  --     require("vague").setup({
  --       -- optional configuration here
  --     })
  --     vim.cmd("colorscheme vague")
  --   end
  -- }
}
