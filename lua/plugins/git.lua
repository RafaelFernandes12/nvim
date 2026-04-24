return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { noremap = true, silent = true }),
        vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", { noremap = true, silent = true }),
        vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { noremap = true, silent = true }),
      })
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",

      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
      "echasnovski/mini.pick",
    },
    config = function()
      require("neogit").setup({
        integrations = {
          diffview = true,
        },
      })
      local keymap = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      keymap("n", "<leader>gg", ":Neogit<CR>", opts)
      keymap("n", "<leader>gl", ":Neogit log<CR>", opts)
    end,
  },
  {
    'akinsho/git-conflict.nvim', version = "*", config = true
  },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
      -- or "fzf-lua" or "snacks" or "default"
      picker = "telescope",
      -- bare Octo command opens picker of commands
      enable_builtin = true,
    },
    keys = {
      {
        "<leader>oi",
        "<CMD>Octo issue list<CR>",
        desc = "List GitHub Issues",
      },
      {
        "<leader>op",
        "<CMD>Octo pr list<CR>",
        desc = "List GitHub PullRequests",
      },
      {
        "<leader>od",
        "<CMD>Octo discussion list<CR>",
        desc = "List GitHub Discussions",
      },
      {
        "<leader>on",
        "<CMD>Octo notification list<CR>",
        desc = "List GitHub Notifications",
      },
      {
        "<leader>os",
        function()
          require("octo.utils").create_base_search_command { include_current_repo = true }
        end,
        desc = "Search GitHub",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- OR "ibhagwan/fzf-lua",
      -- OR "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  }
}
