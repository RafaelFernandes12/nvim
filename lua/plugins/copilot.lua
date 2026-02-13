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
        prompts = {
          AdjustToNest = {
            prompt = "Adjust this code to nestjs",
            resources = "buffer",
            system_prompt = 'COPILOT_EXPLAIN',
            callback = function(response)
              vim.notify("Adjusted to NestJS: " .. response:sub(1, 50) .. "...")
            end,
            mappings = {
              visual = "<leader>pn",
            }
          }

        },

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
          resources = "buffer",
          system_prompt = 'COPILOT_EXPLAIN',
        })
    end, { desc = "CopilotChat - Fix selected code with diagnostics" }),

    vim.keymap.set('n', '<leader>pd', function()
      local chat = require("CopilotChat")
      chat.ask(
        'Add a description for each field of the input, object types and resolvers in the graphql schema in the current buffer. write it in portuguese. Just write the description for graphql, dont bother with other code',
        {
          resources = "buffer",
          selection = false,
          auto_insert_mode = false,
        })
    end, { desc = "CopilotChat - write graphql docs" }),

    vim.keymap.set('n', '<leader>pc', function()
      local chat = require("CopilotChat")
      vim.cmd(":wa")
      vim.fn.system("git add .")
      chat.ask(
        'Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.',
        {
          resources = {
            'gitdiff:staged',
          },
          selection = false,
          auto_insert_mode = false,
          callback = function(response)
            local cleaned = response.content:gsub("^```gitcommit\n", ""):gsub("\n```$", "")
            vim.fn.system({ "git", "commit", "-m", cleaned })
            vim.cmd("close")
            vim.cmd(":Neogit")
          end,
        })
    end, { desc = "CopilotChat - Fix selected code with diagnostics" }),

    vim.keymap.set('n', '<leader>pb', function()
      require("CopilotChat").open({
        resources = "buffer",
        insert_mode = true,
        cursor_position = { line = 2, col = 1 },
      })
    end, { desc = "CopilotChat - Open with prefilled text" }),

    vim.keymap.set('n', '<leader>pw', function()
      local chat = require("CopilotChat")
      local buf = vim.api.nvim_get_current_buf()
      local path = vim.api.nvim_buf_get_name(buf)
      chat.open({
        resources = "files:" .. path,
        insert_mode = false,
      })
    end, { desc = "CopilotChat - Add file path context" }),

    vim.keymap.set('n', '<leader>pf', function()
      require("CopilotChat").open({
        resources = "files",
        insert_mode = true,
        cursor_position = { line = 2, col = 1 },
      })
    end, { desc = "CopilotChat - Open with prefilled text" }),


    keys = {
      { "<leader>pp", ":CopilotChatToggle<CR>",       mode = "n", desc = "Toggle Code" },
      { "<leader>pe", ":CopilotChatExplain<CR>",      mode = "v", desc = "Explain Code" },
      -- { "<leader>pc", ":CopilotChatCommit<CR>",      mode = "v", desc = "Explain Code" },
      { "<leader>po", ":CopilotChatOptimize<CR>",     mode = "v", desc = "Optmize Code" },
      -- { "<leader>pd", ":CopilotChatDocs<CR>",         mode = "v", desc = "Create docs for the fields, input and object types for graphql, if its a resolver, create docs for the query and mutations" },
      { "<leader>pt", ":CopilotChatTests<CR>",        mode = "v", desc = "test Code" },
      { "<leader>pn", ":CopilotChatAdjustToNest<CR>", mode = "v", desc = "adjust to nest Code" },
    }
  },
}
