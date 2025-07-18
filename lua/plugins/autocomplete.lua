return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "github/copilot.vim",
    {
      "mistweaverco/kulala-cmp-graphql.nvim", -- GraphQL source for nvim-cmp in http files
      opts = {},
      ft = "http",
    },
    "tailwind-tools",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local kind_formatter = lspkind.cmp_format({
      mode = "symbol", -- show only symbol annotations
      maxwidth = 50,
      -- menu = {
      --   buffer = "[buf]",
      --   nvim_lsp = "[LSP]",
      --   nvim_lua = "[api]",
      --   path = "[path]",
      --   luasnip = "[snip]",
      -- },
    })

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Enter>"] = cmp.mapping.confirm({ select = false }),
      }),
      window = {
        completion = cmp.config.window.bordered({
          border = "rounded",
          -- winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None"
        }),
        documentation = cmp.config.window.bordered({
          border = "rounded",
          -- winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None"
        }),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        -- { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        -- { name = "nvim_lua" },
        { name = "tailwindcss" },
        -- { name = "codeium" },
      }),
      experimental = { ghost_text = true },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        expandable_indicator = true,
        format = function(entry, vim_item)
          vim_item = kind_formatter(entry, vim_item)
          return vim_item
        end,
      },
    })
    cmp.setup.filetype({ "sql" }, {
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
      },
    })
    cmp.setup.filetype("http", {
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "kulala-cmp-graphql" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
