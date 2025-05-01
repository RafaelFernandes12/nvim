return {
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup({
        menu = {
          width = vim.api.nvim_win_get_width(0) - 20, -- Optional: Adjust menu width
        },
      })

      -- Example keymaps for Harpoon
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      map("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>", opts)     -- Add file to Harpoon
      map("n", "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts) -- Toggle Harpoon menu
      map("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)      -- Navigate to file 1
      map("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)      -- Navigate to file 2
      map("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)      -- Navigate to file 3
      map("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", opts)      -- Navigate to file 4
      map("n", "<leader>5", ":lua require('harpoon.ui').nav_file(5)<CR>", opts)      -- Navigate to file 4
      map("n", "<leader>6", ":lua require('harpoon.ui').nav_file(6)<CR>", opts)      -- Navigate to file 4
      map("n", "<leader>7", ":lua require('harpoon.ui').nav_file(7)<CR>", opts)      -- Navigate to file 4
      map("n", "<leader>8", ":lua require('harpoon.ui').nav_file(8)<CR>", opts)      -- Navigate to file 4
      map("n", "<leader>9", ":lua require('harpoon.ui').nav_file(9)<CR>", opts)      -- Navigate to file 4
    end,
  },
}
