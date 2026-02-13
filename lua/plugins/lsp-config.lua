return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim",                   opts = {} },
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Mason setup
    mason.setup()
    mason_lspconfig.setup()

    -- Shared capabilities for all LSP servers
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Shared on_attach function for all servers
    local function on_attach(_, bufnr)
      -- Key mappings for LSP functionality
      local opts = { buffer = bufnr, silent = true }
      local keymaps = {
        ["<leader>lr"] = { "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
        ["<leader>ld"] = { vim.lsp.buf.definition, "Go to definition" },
        ["<leader>li"] = { "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
        ["<leader>lt"] = { "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
        ["<leader>lc"] = { vim.lsp.buf.code_action, "See available code actions" },
        ["<leader>lsr"] = { vim.lsp.buf.rename, "Smart rename" },
        ["<leader>D"] = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics" },
        ["<leader>d"] = { vim.diagnostic.open_float, "Show line diagnostics" },
        ["K"] = { vim.lsp.buf.hover, "Show documentation" },
      }

      for key, mapping in pairs(keymaps) do
        opts.desc = mapping[2]
        vim.keymap.set("n", key, mapping[1], opts)
      end
    end

    -- Default configs for known servers (add more as needed)
    local server_configs = {
      clangd = {
        cmd = {
          "clangd",
          "--header-insertion=never",
          "--query-driver=/usr/bin/g++",
          "--compile-commands-dir=build"
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "h", "hpp" },
        root_dir = vim.fn.getcwd,
      },
      cssls = {
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less" },
        root_dir = vim.fn.getcwd,
      },
      graphql = {
        cmd = { "graphql-lsp", "server", "-m", "stream" },
        filetypes = { "graphql", "typescriptreact", "javascriptreact" },
        root_dir = vim.fn.getcwd,
      },
      html = {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" },
        root_dir = vim.fn.getcwd,
      },
      lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_dir = vim.fn.getcwd,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
          },
        },
      },
      prismals = {
        cmd = { "prisma-language-server", "--stdio" },
        filetypes = { "prisma" },
        root_dir = vim.fn.getcwd,
      },
      pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_dir = vim.fn.getcwd,
      },
      tailwindcss = {
        cmd = { "tailwindcss-language-server", "--stdio" },
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_dir = vim.fn.getcwd,
      },
      vtsls = {
        cmd = { "vtsls", "--stdio" },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
        root_dir = vim.fn.getcwd,
      },
      marksman = {
        cmd = { "marksman", "server" },
        filetypes = { "markdown", "markdown.mdx" },
        root_dir = vim.fn.getcwd,
      },
    }

    -- Start all installed servers with their configs
    local servers = mason_lspconfig.get_installed_servers()
    for server, config in pairs(server_configs) do
      config.capabilities = capabilities
      config.on_attach = on_attach
      config.name = server
      for _, ft in ipairs(config.filetypes or {}) do
        vim.api.nvim_create_autocmd("FileType", {
          pattern = ft,
          callback = function(args)
            -- Prevent duplicate clients
            local bufnr = args.buf
            local active = false
            for _, client in pairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
              if client.name == server then
                active = true
                break
              end
            end
            if not active then
              vim.lsp.start(vim.tbl_deep_extend("force", config, { root_dir = vim.fn.getcwd() }))
            end
          end,
          group = vim.api.nvim_create_augroup("LspStart_" .. server, { clear = true }),
        })
      end
    end
  end,
}
