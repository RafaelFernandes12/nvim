return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",  -- Add this line to enable text objects
	},
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			-- Specify parsers to install
			ensure_installed = {
				"lua",
				"javascript",
				"typescript",
				"html",
				"css",
				"python",
				"bash",
				"json",
				"yaml",
				"java",
			},

			modules = {},
			sync_install = false,

			ignore_install = { "haskell" },

			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = {
				enable = true,
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},

			-- Enable and configure text objects
			textobjects = {
				select = {
					enable = true,
					keymaps = {
						["aa"] = "@parameter.outer",  -- Select outer parameter
						["ia"] = "@parameter.inner",  -- Select inner parameter
						["af"] = "@function.outer",   -- Select outer function
						["if"] = "@function.inner",   -- Select inner function
						["ac"] = "@class.outer",      -- Select outer class
						["ic"] = "@class.inner",      -- Select inner class
					},
				},
				move = {
					enable = true,
					set_jumps = true,  -- Update jumps
					keymaps = {
						["m"] = "@function.outer",  -- Move to next function
						["M"] = "@function.outer",  -- Move to previous function
						["["] = "@class.outer",     -- Move to previous class
						["]"] = "@class.outer",     -- Move to next class
					},
				},
				swap = {
					enable = true,
					keymaps = {
						["<leader>a"] = "@parameter.inner",  -- Swap parameters
					},
				},
			},
		})
	end,
}
