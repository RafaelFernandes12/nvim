return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Mason setup
		mason.setup()
		mason_lspconfig.setup()

		-- Shared capabilities for all LSP servers
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Shared on_attach function for all servers
		local function on_attach(client, bufnr)
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
				["<leader>lrs"] = { ":LspRestart<CR>", "Restart LSP" },
				["<leader>lR"] = { ":LspRenameFile<CR>", "Rename current file" },
			}

			for key, mapping in pairs(keymaps) do
				opts.desc = mapping[2]
				vim.keymap.set("n", key, mapping[1], opts)
			end
		end

		-- Setup LSP servers
		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,
			["vtsls"] = function()
				lspconfig.vtsls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,
			["html"] = function()
				lspconfig.html.setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
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
				})
			end,
		})
	end,
}
