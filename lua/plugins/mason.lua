return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  lazy = false,
  config = function()
    require("mason").setup()
    local mason_lsp = require("mason-lspconfig")

    mason_lsp.setup({
      ensure_installed = {
        "vtsls",
        "js-debug-adapter",
        "html",
        "tailwindcss",
        "lua_ls",
        "jdtls",
        "pyright",
        "graphql",
        "eslint_d",
        "prettier",
        "cssls",
        "clangd"
      },
      automatic_installation = true,
    })
  end,
}
