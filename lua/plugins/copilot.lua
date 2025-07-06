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
        chat_autocomplete = true,
        auto_insert_mode = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        mappings = {
          reset = {
            normal = "<leader>pq",
            insert = "<C-q>"
          }

        },
        window = {
          width = 0.4,
        },
      }
    end,

    vim.keymap.set('v', '<leader>pi', function()
      local chat = require("CopilotChat")

      local start_line = vim.fn.line("v")
      local end_line = vim.fn.line(".")
      if start_line > end_line then
        start_line, end_line = end_line, start_line
      end
      local bufnr = vim.api.nvim_get_current_buf()
      local diagnostics = vim.diagnostic.get(bufnr)
      local selected_diags = {}
      for _, d in ipairs(diagnostics) do
        if d.lnum >= (start_line - 1) and d.lnum <= (end_line - 1) then
          table.insert(selected_diags, d)
        end
      end
      local diag_str = table.concat(vim.tbl_map(function(d) return d.message end, selected_diags), "\n")

      chat.ask(
        'Fix the selected code, explain what was wrong and how your changes address the problems, here are the diagnostics' ..
        diag_str, {
          context = "buffer",
          system_prompt = 'COPILOT_EXPLAIN',
        })
    end, { desc = "CopilotChat - Fix selected code with diagnostics" }),

    vim.keymap.set('n', '<leader>pc', function()
      local chat = require("CopilotChat")
      vim.cmd(":wa")
      vim.fn.system("git add .")
      chat.ask(
        'Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.',
        {
          context = "git:staged",
          selection = false,
          auto_insert_mode = false,
          callback = function(response)
            local cleaned = response:gsub("^```gitcommit\n", ""):gsub("\n```$", "")
            print("Commit message copied to clipboard.")
            vim.cmd("git commit -m '" .. cleaned .. "'")
            -- vim.fn.system("wl-copy", cleaned)
            vim.cmd("close")
          end,
        })
    end, { desc = "CopilotChat - Fix selected code with diagnostics" }),

    vim.keymap.set('n', '<leader>pb', function()
      require("CopilotChat").open({
        context = "buffer",
        insert_mode = true,
        cursor_position = { line = 2, col = 1 },
      })
    end, { desc = "CopilotChat - Open with prefilled text" }),

    vim.keymap.set('n', '<leader>pw', function()
      require("CopilotChat").open({
        context = "files",
        insert_mode = true,
        cursor_position = { line = 2, col = 1 },
      })
    end, { desc = "CopilotChat - Open with prefilled text" }),


    keys = {
      { "<leader>pp", ":CopilotChatToggle<CR>",   mode = "n", desc = "Explain Code" },
      { "<leader>pe", ":CopilotChatExplain<CR>",  mode = "v", desc = "Explain Code" },
      { "<leader>po", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optmize Code" },
      { "<leader>pd", ":CopilotChatDocs<CR>",     mode = "v", desc = "docs Code" },
      { "<leader>pt", ":CopilotChatTests<CR>",    mode = "v", desc = "test Code" },
      -- { "<leader>pc", ":CopilotChatCommit<CR>",   mode = "n", desc = "test Code" },
    }
  },
}
