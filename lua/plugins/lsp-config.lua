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

		mason.setup()
		mason_lspconfig.setup()

		local capabilities = cmp_nvim_lsp.default_capabilities()
		local keymap = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				local keymaps = {
					["gr"] = { "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
					["gd"] = { vim.lsp.buf.declaration, "Go to declaration" },
					["gi"] = { "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
					["gt"] = { "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
					["<leader>ca"] = { vim.lsp.buf.code_action, "See available code actions" },
					["<leader>rn"] = { vim.lsp.buf.rename, "Smart rename" },
					["<leader>D"] = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics" },
					["<leader>d"] = { vim.diagnostic.open_float, "Show line diagnostics" },
					["[d"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
					["]d"] = { vim.diagnostic.goto_next, "Go to next diagnostic" },
					["K"] = { vim.lsp.buf.hover, "Show documentation" },
					["<leader>rs"] = { ":LspRestart<CR>", "Restart LSP" },
				}

				for key, mapping in pairs(keymaps) do
					opts.desc = mapping[2]
					keymap.set("n", key, mapping[1], opts)
				end
			end,
		})

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({ capabilities = capabilities })
			end,
			["ts_ls"] = function()
				lspconfig.ts_ls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
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
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
							telemetry = { enable = false },
						},
					},
				})
			end,
		})
	end,
}
