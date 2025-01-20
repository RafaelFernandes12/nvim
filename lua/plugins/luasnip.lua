return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")

		-- Keymaps for LuaSnip
		vim.keymap.set({ "i", "s" }, "¹", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "²", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "³", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })

		-- Load Snippets
		local ts_snippets = require("plugins.snippets.ts")
		ls.add_snippets("typescriptreact", ts_snippets)
		ls.add_snippets("typescript", ts_snippets)
		local md_snippets = require("plugins.snippets.md")
		ls.add_snippets("markdown", md_snippets)
		local lua_snippets = require("plugins.snippets.lua")
		ls.add_snippets("lua", lua_snippets)
	end,
}
