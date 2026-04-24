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
      local telescope = require("telescope")
      local telescope_config = require("telescope.config")
      local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

      vim.list_extend(vimgrep_arguments, {
        "--hidden",
        "--no-ignore",
        "--glob",
        "!.git/*",
      })

      telescope.setup({
        defaults = {
          vimgrep_arguments = vimgrep_arguments,
          file_ignore_patterns = {
            "node_modules",
            "target"
          },
          hidden = true,
          find_command = {
            "fd",
            "--type",
            "f",
            "--hidden",
            "--no-ignore",
            "--exclude",
            ".git",
            "--exclude",
            "node_modules",
            "--exclude",
            "target",
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({
          hidden = true,
          no_ignore = true,
          no_ignore_parent = true,
          find_command = {
            "fd",
            "--type",
            "f",
            "--hidden",
            "--no-ignore",
            "--exclude",
            ".git",
            "--exclude",
            "node_modules",
            "--exclude",
            "target",
          },
        })
      end, { desc = "Telescope find files" })
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
      end, { desc = "Open tmux split and Telescope in ~/source/notes" })
      vim.keymap.set("n", "<leader>nn", function()
        vim.fn.system("tmux split-window -h 'cd ~/source/notes && nvim' ")
      end, { desc = "Open tmux split and Telescope in ~/source/notes" })

      telescope.load_extension("ui-select")
    end,
  },
}
