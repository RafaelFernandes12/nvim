-- Lua
return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
    -- add any custom options here
    vim.keymap.set("n", "<leader>es", function() require("persistence").load() end),

    -- select a session to load
    vim.keymap.set("n", "<leader>eS", function() require("persistence").select() end),

    -- load the last session
    vim.keymap.set("n", "<leader>el", function() require("persistence").load({ last = true }) end),

    -- stop Persistence => session won't be saved on exit
    vim.keymap.set("n", "<leader>ed", function() require("persistence").stop() end)
  }
  -- load the session for the current directory
}
