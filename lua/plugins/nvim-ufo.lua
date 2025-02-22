return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  config = function()
    vim.keymap.set("n", "zr", require("ufo").openAllFolds)
    vim.keymap.set("n", "zm", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zo", "zO", { noremap = true, silent = true })
    -- Setup ufo plugin
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" }
      end,
    })
  end,
}
