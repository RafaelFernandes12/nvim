return {
	-- "nvim-java/nvim-java",
	-- config = function()
	-- 	-- Setup Java
	-- 	require("java").setup()
	--
	-- 	-- Define keymaps
	-- 	local keymaps = {
	-- 		["<leader>lr"] = { "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
	-- 		["<leader>ld"] = { vim.lsp.buf.definition, "Go to definition" },
	-- 		["<leader>li"] = { "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
	-- 		["<leader>lt"] = { "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
	-- 		["<leader>lc"] = { vim.lsp.buf.code_action, "See available code actions" },
	-- 		["<leader>lsr"] = { vim.lsp.buf.rename, "Smart rename" },
	-- 		["<leader>D"] = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics" },
	-- 		["<leader>d"] = { vim.diagnostic.open_float, "Show line diagnostics" },
	-- 		["K"] = { vim.lsp.buf.hover, "Show documentation" },
	-- 		["<leader>lrs"] = { ":LspRestart<CR>", "Restart LSP" },
	-- 		["<leader>lR"] = { ":LspRenameFile<CR>", "Rename current file" },
	-- 		["<leader>tu"] = { "<cmd>Neotest run<CR>", "teste" },
	-- 		-- create a test to run the nearest test
	-- 		-- ["<leader>tn"] = { ":require('java').test.run_nearest_test()", "Run nearest test" },
	-- 	}
	--
	-- 	-- Function to apply keymaps
	-- 	local function set_lsp_keymaps(bufnr)
	-- 		for key, map in pairs(keymaps) do
	-- 			vim.keymap.set("n", key, map[1], { desc = map[2], buffer = bufnr, noremap = true, silent = true })
	-- 		end
	-- 	end
	--
	-- 	-- Setup jdtls (Java Language Server) with on_attach for keymaps
	-- 	require("lspconfig").jdtls.setup({
	-- 		on_attach = function(client, bufnr)
	-- 			set_lsp_keymaps(bufnr)
	-- 		end,
	--      handlers = {
	-- 	-- By assigning an empty function, you can remove the notifications
	-- 	-- printed to the cmd
	-- 	["$/progress"] = function(_, result, ctx) end,
	-- },
	-- 		settings = {
	-- 			java = {
	-- 				format = {
	-- 					enabled = true,
	-- 				},
	-- 			},
	-- 		},
	-- 	})
	-- end,
}
