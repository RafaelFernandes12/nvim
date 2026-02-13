return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  lazy = false,
  config = function()
    require("mason").setup()
    local mason_lsp = require("mason-lspconfig")

    mason_lsp.setup({
      ensure_installed = {
        "vtsls",
        -- "ts_ls",
        "html",
        "tailwindcss",
        "lua_ls",
        "jdtls",
        "pyright",
        "cssls",
        "clangd"
      },
      automatic_installation = true,
    })
  end,
}
