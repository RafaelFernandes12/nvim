return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Required for icons
    "MunifTanjim/nui.nvim",        -- Required for UI components
  },
  config = function()
    -- REMOVED: Deprecated vim.fn.sign_define calls
    -- These should be configured globally via vim.diagnostic.config() in your main LSP/diagnostics setup.
    -- Neo-tree will automatically pick up the global diagnostic signs.

    -- Your keymap remains the same
    vim.keymap.set("n", "<leader>nt", ":Neotree filesystem toggle left<CR>", { silent = true })

    -- Optional: Neo-tree specific settings (add if you need them)
    require("neo-tree").setup({
      close_if_last_window = true, -- Close Neo-tree if it's the last window
      filesystem = {
        filtered_items = {
          visible = true, -- This tells Neo-tree to show dotfiles and hidden files in the explorer
          hide_dotfiles = false,
          hide_git_ignored = false,
          hide_hidden = false, -- e.g. .DS_Store
        },
        -- You can configure other aspects like follow_current_file, etc.
      },
      window = {
        width = 30, -- Adjust default width
        mapping_options = {
          noremap = true,
          nowait = true,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true, -- Auto-reveal the current buffer in the tree
        },
      },
      -- If you want custom icons for diagnostic severity in neo-tree,
      -- neo-tree.nvim's setup has a `diagnostics` table you can configure,
      -- but it still relies on your global `vim.diagnostic.config` for the actual logic.
      diagnostics = {
        icons = {
          hint = "",
          info = "",
          warn = "",
          error = "",
        },
        -- These icons are used by Neo-tree specifically for its display.
        -- The colors come from the standard Neovim diagnostic highlight groups.
      },
    })
  end,
}
