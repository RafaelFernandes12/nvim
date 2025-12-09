return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = {
            "node_modules",
          },
          hidden = true,
          find_command = { "fd", "--type", "f", "--hidden", "--exclude", "node_modules" },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope find keymaps" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fr", function()
        local word = vim.fn.expand("<cword>")
        require("telescope.builtin").grep_string({ search = word })
      end, { desc = "Telescope grep word under cursor" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
      -- vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Telescope registers" })
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Telescope lsp_document_symbols" })
      -- vim.keymap.set(
      --   "n",
      --   "<leader>fw",
      --   builtin.lsp_workspace_symbols,
      --   { desc = "Telescope lsp_workspace_symbols" }
      -- )
      -- vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Telescope marks" })

      vim.keymap.set("n", "<leader>cc", function()
        vim.fn.system(
          "tmux split-window -h 'cd ~/.config/nvim && nvim +\"Telescope find_files cwd=~/.config/nvim\"'"
        )
      end, { desc = "Open tmux split and Telescope in ~/source/repos/notes" })
      -- vim.keymap.set("n", "<leader>nn", function()
      --   vim.fn.system("tmux split-window -h 'cd ~/source/repos/notes && nvim' ")
      -- end, { desc = "Open tmux split and Telescope in ~/source/repos/notes" })

      require("telescope").load_extension("ui-select")
    end,
  },
}
