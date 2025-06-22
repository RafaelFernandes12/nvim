return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float",
    })

    vim.keymap.set("n", "<C-p>", function()
      vim.cmd("ToggleTerm 1")
    end, { noremap = true, silent = true })

    vim.keymap.set("t", "<C-p>", function()
      vim.schedule(function()
        vim.cmd("ToggleTerm 1")
      end)
    end, { noremap = true, silent = true })

    -- Keymap for switching to float direction
    vim.keymap.set("n", "<C-n>", function()
      vim.cmd("ToggleTerm 2")
    end, { noremap = true, silent = true })

    vim.keymap.set("t", "<C-n>", function()
      vim.schedule(function()
        vim.cmd("ToggleTerm 2")
      end)
    end, { noremap = true, silent = true })

    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
  end,
}
