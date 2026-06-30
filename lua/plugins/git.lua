return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gs = require("gitsigns")
      gs.setup({
        word_diff = false, -- toggle on demand with <leader>gw
      })
      local opts = { noremap = true, silent = true }
      -- vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", opts)
      vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", opts)
      vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", opts)

      -- Inline / same-buffer review.
      vim.keymap.set("n", "<leader>gi", gs.preview_hunk_inline,
        vim.tbl_extend("force", opts, { desc = "Gitsigns: inline hunk diff" }))
      vim.keymap.set("n", "<leader>gd", gs.toggle_deleted,
        vim.tbl_extend("force", opts, { desc = "Gitsigns: toggle deleted lines inline" }))
      vim.keymap.set("n", "<leader>gw", gs.toggle_word_diff,
        vim.tbl_extend("force", opts, { desc = "Gitsigns: toggle word diff" }))
      -- Navigate hunks while reviewing.
      vim.keymap.set("n", "]h", gs.next_hunk, vim.tbl_extend("force", opts, { desc = "Gitsigns: next hunk" }))
      vim.keymap.set("n", "[h", gs.prev_hunk, vim.tbl_extend("force", opts, { desc = "Gitsigns: prev hunk" }))
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
      keymap("n", "<leader>gl", ":Neogit log<CR>", opts)
      vim.keymap.set("n", "<leader>gg", function()
        require("git_repo_picker").pick(function(path)
          require("neogit").open(path and { cwd = path } or {})
        end)
      end, { noremap = true, silent = true, desc = "Neogit: open (pick sub-repo if many)" })
    end,
  },
  {
    'akinsho/git-conflict.nvim', version = "*", config = true
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewFileHistory",
    },
    keys = {
      {
        "<leader>gv",
        function()
          require("git_repo_picker").pick(function(path)
            vim.cmd("DiffviewOpen" .. (path and (" -C" .. path) or ""))
          end)
        end,
        desc = "Diffview: open (pick sub-repo if many)",
      },
      { "<leader>gh", "<CMD>DiffviewFileHistory<CR>",   desc = "Diffview: repo history" },
      { "<leader>gf", "<CMD>DiffviewFileHistory %<CR>", desc = "Diffview: file history" },
      { "<leader>gt", "<CMD>DiffviewToggleFiles<CR>",   desc = "Diffview: toggle file panel" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true,
        },
      },
    },
    config = function(_, opts)
      require("diffview").setup(opts)
    end,
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
