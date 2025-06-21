return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float",
    })

    -- Corrected mapping for ToggleTerm command
    -- Mappings for multiple terminal instances
    vim.keymap.set("n", "<C-p>", function()
      vim.cmd("ToggleTerm 1")
    end, { noremap = true, silent = true })

    vim.keymap.set("t", "<C-p>", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
      vim.schedule(function()
        vim.cmd("ToggleTerm 1")
      end)
    end, { noremap = true, silent = true })

    -- Keymap for switching to float direction
    vim.keymap.set("n", "<C-n>", function()
      vim.cmd("ToggleTerm 2")
    end, { noremap = true, silent = true })

    vim.keymap.set("t", "<C-n>", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
      vim.schedule(function()
        vim.cmd("ToggleTerm 2")
      end)
    end, { noremap = true, silent = true })

    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
  end,
}
