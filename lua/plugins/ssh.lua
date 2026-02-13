return {
  "nosduco/remote-sshfs.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    require('remote-sshfs').setup({})
    local api = require('remote-sshfs.api')

    vim.keymap.set('n', '<leader>sc', api.connect, { desc = "SSHFS Connect" })
    vim.keymap.set('n', '<leader>sd', api.disconnect, { desc = "SSHFS Disconnect" })
    vim.keymap.set('n', '<leader>se', api.edit, { desc = "SSHFS Edit Remote" })
    -- Override telescope find_files and live_grep to be dynamic based on SSHFS connection
    local builtin = require("telescope.builtin")
    local connections = require("remote-sshfs.connections")
    vim.keymap.set("n", "<leader>ff", function()
      if connections.is_connected() then
        api.find_files()
      else
        builtin.find_files()
      end
    end, { desc = "Find Files (local/remote)" })
    vim.keymap.set("n", "<leader>fg", function()
      if connections.is_connected() then
        api.live_grep()
      else
        builtin.live_grep()
      end
    end, { desc = "Live Grep (local/remote)" })
  end,
}
