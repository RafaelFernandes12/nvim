return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	lazy = false,
	config = function()
		require("mason").setup()
		local mason_lsp = require("mason-lspconfig")

		mason_lsp.setup({
			ensure_installed = {
				"ts_ls",
				"html",
				"tailwindcss",
				"lua_ls",
			},
			automatic_installation = true,
		})
	end,
}
