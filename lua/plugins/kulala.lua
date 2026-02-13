return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>rs", desc = "Send request" },
    { "<leader>ra", desc = "Send all requests" },
    { "<leader>rb", desc = "Open scratchpad" },
  },
  ft = { "http", "rest", "graphql" },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>r",
    kulala_keymaps_prefix = "",
    -- lsp = { formatter = true },
    ui = {
      -- Default is 32768 (32KB). Increase so large JSON shows in the UI.
      max_response_size = 5 * 1024 * 1024, -- 5MB
      win_opts = {
        wo = { number = true, wrap = true }, -- window options
      },
    },
  },
}
