return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float",
    })

    local opencode = require("opencode-toggleterm").setup()

    vim.keymap.set("n", "<C-p>", function()
      vim.cmd("ToggleTerm 1")
    end, { noremap = true, silent = true })

    vim.keymap.set("t", "<C-p>", function()
      vim.schedule(function()
        vim.cmd("ToggleTerm 1")
      end)
    end, { noremap = true, silent = true })

    vim.keymap.set("n", "<C-n>", function()
      opencode.toggle()
    end, { noremap = true, silent = true })

    vim.keymap.set("t", "<C-n>", function()
      vim.schedule(opencode.toggle)
    end, { noremap = true, silent = true })

    vim.keymap.set("n", "<C-o>", function()
      vim.cmd("ToggleTerm 3")
    end, { noremap = true, silent = true })

    vim.keymap.set("t", "<C-o>", function()
      vim.schedule(function()
        vim.cmd("ToggleTerm 3")
      end)
    end, { noremap = true, silent = true })

    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
  end,

}
