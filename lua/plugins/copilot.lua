return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                          -- Only on MacOS or Linux
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        window = {
          width = 0.4,
        },
      }
    end,

    vim.keymap.set('n', '<leader>pb', function()
      local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then
        require("CopilotChat").ask(input, {
          selection = require("CopilotChat.select").buffer
        })
      end
    end, { desc = "CopilotChat - Quick chat" }),

    keys = {
      { "<leader>pp", ":CopilotChatToggle<CR>",   mode = "n", desc = "Explain Code" },
      { "<leader>pe", ":CopilotChatExplain<CR>",  mode = "v", desc = "Explain Code" },
      { "<leader>pr", ":CopilotChatReview<CR>",   mode = "v", desc = "Review Code" },
      { "<leader>po", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optmize Code" },
      { "<leader>pd", ":CopilotChatDocs<CR>",     mode = "v", desc = "docs Code" },
      { "<leader>pt", ":CopilotChatTests<CR>",    mode = "v", desc = "test Code" },
      { "<leader>pc", ":CopilotChatCommit<CR>",   mode = "n", desc = "test Code" },

    },

    -- Change Copilot reset mapping from <C-l> to <C-o>
  },
}
