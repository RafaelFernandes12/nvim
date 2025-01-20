return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  config = function()
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.foldingRange = {
    --   dynamicRegistration = false,
    --   lineFoldingOnly = true,
    -- }
    --
    -- local lspconfig = require("lspconfig")
    -- local language_servers = lspconfig.util.available_servers()
    -- for _, ls in ipairs(language_servers) do
    --   lspconfig[ls].setup({
    --     capabilities = capabilities,
    --   })
    -- end
    --
    vim.keymap.set("n", "zr", require("ufo").openAllFolds)
    vim.keymap.set("n", "zm", require("ufo").closeAllFolds)

    -- Setup ufo plugin
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" }
      end,
    })
  end,
}
