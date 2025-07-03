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
      local bufnr = vim.api.nvim_get_current_buf()
      local line = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-indexed
      local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })
      local diag_str2 = table.concat(vim.tbl_map(function(d) return d.message end, diagnostics), "\n")

      return {
        -- prompts = {
        --   -- NewFix = {
        --   --   prompt = "Fix the select Code, heres the diagnostics: " .. diag_str2,
        --   --   context = "buffer",
        --   --   -- selection = select.visual,
        --   --   system_prompt = 'COPILOT_EXPLAIN',
        --   --   mappings = {
        --   --     visual = "<leader>pi",
        --   --   }
        --   -- }
        -- },
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
    -- vim.keymap.set('v', '<leader>pi', function()
    --   local bufnr = vim.api.nvim_get_current_buf()
    --   local line = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-indexed
    --   local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })
    --   local diag_str = table.concat(vim.tbl_map(function(d) return d.message end, diagnostics), "\n")
    --   print(diag_str)
    --   local selected_text = table.concat(
    --     vim.api.nvim_buf_get_lines(bufnr, vim.fn.getpos("'<")[2] - 1, vim.fn.getpos("'>")[2], false), "\n")
    --   local prompt = ""
    --   if diag_str ~= "" then
    --     prompt = "Diagnostics:\n" .. diag_str .. "\n"
    --   end
    --   prompt = prompt .. "Fix the following code:\n" .. selected_text
    --   require("CopilotChat").open({
    --     prompt = prompt,
    --     context = "buffer",
    --     system_prompt = 'COPILOT_EXPLAIN',
    --     insert_mode = true,
    --   })
    -- end, { desc = "CopilotChat - Fix selected code with diagnostics" }),

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
      { "<leader>pi", ":CopilotChatFix<CR>",      mode = "v", desc = "Fix Code" },
      { "<leader>pc", ":CopilotChatCommit<CR>",   mode = "n", desc = "test Code" },
    }
  },
}
