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
				"vtsls",
				"html",
				"tailwindcss",
				"lua_ls",
        "pyright"
			},
			automatic_installation = true,
		})
	end,
}
