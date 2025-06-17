return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          javascript = { "eslint_d", "prettier" },
          typescript = { "eslint_d", "prettier" },
          javascriptreact = { "eslint_d", "prettier" },
          typescriptreact = { "eslint_d", "prettier" },
          -- javascript = { "eslint_d" --[[ , "prettier" ]] },
          -- typescript = { "eslint_d" --[[ , "prettier" ]] },
          -- javascriptreact = { "eslint_d" --[[ , "prettier" ]] },
          -- typescriptreact = { "eslint_d" --[[ , "prettier" ]] },
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
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   config = function()
  --     local null_ls = require("null-ls")
  --
  --     local root_has_file = function(files)
  --       return function(utils)
  --         return utils.root_has_file(files)
  --       end
  --     end
  --
  --     local eslint_root_files = { ".eslintrc", ".eslintrc.js", ".eslintrc.json" }
  --     local prettier_root_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" }
  --     local stylua_root_files = { "stylua.toml", ".stylua.toml" }
  --     local elm_root_files = { "elm.json" }
  --
  --     local opts = {
  --       eslint_formatting = {
  --         condition = function(utils)
  --           local has_eslint = root_has_file(eslint_root_files)(utils)
  --           local has_prettier = root_has_file(prettier_root_files)(utils)
  --           return has_eslint and not has_prettier
  --         end,
  --       },
  --       eslint_diagnostics = {
  --         condition = root_has_file(eslint_root_files),
  --       },
  --       prettier_formatting = {
  --         condition = root_has_file(prettier_root_files),
  --       },
  --       stylua_formatting = {
  --         condition = root_has_file(stylua_root_files),
  --       },
  --       elm_format_formatting = {
  --         condition = root_has_file(elm_root_files),
  --       },
  --     }
  --
  --     local function on_attach(client, _)
  --       if client.server_capabilities.document_formatting then
  --         vim.cmd("command! -buffer Formatting lua vim.lsp.buf.formatting()")
  --         vim.cmd("command! -buffer FormattingSync lua vim.lsp.buf.formatting_sync()")
  --       end
  --     end
  --
  --     null_ls.setup({
  --       sources = {
  --         null_ls.builtins.diagnostics.eslint_d.with(opts.eslint_diagnostics),
  --         null_ls.builtins.formatting.eslint_d.with(opts.eslint_formatting),
  --         null_ls.builtins.formatting.prettier.with(opts.prettier_formatting),
  --         null_ls.builtins.formatting.stylua.with(opts.stylua_formatting),
  --         null_ls.builtins.formatting.elm_format.with(opts.elm_format_formatting),
  --         null_ls.builtins.code_actions.eslint_d.with(opts.eslint_diagnostics),
  --       },
  --       on_attach = on_attach,
  --     })
  --   end,
  -- },
--   {
--   "neovim/nvim-lspconfig",
--   -- other settings removed for brevity
--   opts = {
--     ---@type lspconfig.options
--     servers = {
--       eslint = {
--         settings = {
--           -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
--           workingDirectories = { mode = "auto" },
--           format = auto_format,
--         },
--       },
--     },
--     setup = {
--       eslint = function()
--         if not auto_format then
--           return
--         end
--
--         local function get_client(buf)
--           return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
--         end
--
--         local formatter = LazyVim.lsp.formatter({
--           name = "eslint: lsp",
--           primary = false,
--           priority = 200,
--           filter = "eslint",
--         })
--
--         -- Use EslintFixAll on Neovim < 0.10.0
--         if not pcall(require, "vim.lsp._dynamic") then
--           formatter.name = "eslint: EslintFixAll"
--           formatter.sources = function(buf)
--             local client = get_client(buf)
--             return client and { "eslint" } or {}
--           end
--           formatter.format = function(buf)
--             local client = get_client(buf)
--             if client then
--               local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
--               if #diag > 0 then
--                 vim.cmd("EslintFixAll")
--               end
--             end
--           end
--         end
--
--         -- register the formatter with LazyVim
--         LazyVim.format.register(formatter)
--       end,
--     },
--   },
-- }
--   ,
--   {
--   "stevearc/conform.nvim",
--   optional = true,
--   ---@param opts ConformOpts
--   opts = function(_, opts)
--     opts.formatters_by_ft = opts.formatters_by_ft or {}
--     for _, ft in ipairs(supported) do
--       opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
--       table.insert(opts.formatters_by_ft[ft], "prettier")
--     end
--
--     opts.formatters = opts.formatters or {}
--     opts.formatters.prettier = {
--       condition = function(_, ctx)
--         return M.has_parser(ctx) and (vim.g.lazyvim_prettier_needs_config ~= true or M.has_config(ctx))
--       end,
--     }
--   end,
-- }
}
