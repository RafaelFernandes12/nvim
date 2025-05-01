return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          -- javascript = { "eslint_d", "prettier" },
          -- typescript = { "eslint_d", "prettier" },
          -- javascriptreact = { "eslint_d", "prettier" },
          -- typescriptreact = { "eslint_d", "prettier" },
          javascript = { "eslint_d" --[[ , "prettier" ]] },
          typescript = { "eslint_d" --[[ , "prettier" ]] },
          javascriptreact = { "eslint_d" --[[ , "prettier" ]] },
          typescriptreact = { "eslint_d" --[[ , "prettier" ]] },
          svelte = { "eslint_d" },
          css = { "eslint_d" },
          html = { "eslint_d" },
          json = { "eslint_d" },
          yaml = { "eslint_d" },
          markdown = { "prettier" },
          graphql = { "eslint_d" },
          liquid = { "eslint_d" },
          lua = { "stylua" },
          python = { "isort", "black" },
        },
        format_on_save = {
          timeout_ms = 1000,
          lsp_fallback = true,
        },
      })
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      -- 	pattern = "*",
      -- 	callback = function(args)
      -- 		require("conform").format({ async = false, lsp_format = "fallback", bufnr = args.buf })
      -- 	end,
      -- })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      vim.env.ESLINT_D_PPID = vim.fn.getpid()
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "pylint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>r", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    -- "nvimtools/none-ls.nvim",
    -- dependencies = {
    --   "nvimtools/none-ls-extras.nvim",
    -- },
    -- config = function()
    --   local null_ls = require("null-ls")
    --   local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    --   null_ls.setup({
    --     sources = {
    --       null_ls.builtins.formatting.stylua,
    --       null_ls.builtins.formatting.eslint_d,
    --       require("none-ls.diagnostics.eslint_d"),
    --     },
    --     vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {}),
    --     on_attach = function(client, bufnr)
    --       if client.supports_method("textDocument/formatting") then
    --         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --         vim.api.nvim_create_autocmd("BufWritePre", {
    --           group = augroup,
    --           buffer = bufnr,
    --           callback = function()
    --             vim.lsp.buf.format({ bufnr = bufnr })
    --             vim.lsp.buf.format({ async = false })
    --             vim.lsp.buf.format({ async = false })
    --             vim.lsp.buf.formatting_sync()
    --           end,
    --         })
    --       end
    --     end,
    --   })
    -- end,
  },
}
