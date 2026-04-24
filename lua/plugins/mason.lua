return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  lazy = false,
  config = function()
    local mason = require("mason")
    local mason_lsp = require("mason-lspconfig")

    local lsp_servers = {
      "vtsls",
      -- "ts_ls",
      "html",
      "tailwindcss",
      "lua_ls",
      "jdtls",
      "pyright",
      "cssls",
      "clangd",
      "gopls",
    }

    mason.setup()

    mason_lsp.setup({
      ensure_installed = lsp_servers,
      automatic_installation = true,
    })
  end,
}
