return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    filetypes = {
      markdown = {
        template = "![$FILE_NAME_NO_EXT]($FILE_PATH)",
      },
    },
  },
  keys = {
    -- suggested keymap
    { "<leader>i", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard markdown" },
  },
}
