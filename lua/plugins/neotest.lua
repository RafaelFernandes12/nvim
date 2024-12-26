return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-jest",
		"rcasia/neotest-java",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-java")({
					command = "mvn",
					args = { "test" },
				}),
				require("neotest-jest")({
					jestCommand = "npm test --",
					jestConfigFile = "custom.jest.config.ts",
					env = { CI = true },
					cwd = function()
						return vim.fn.getcwd()
					end,
				}),
			},
		})
		vim.keymap.set("n", "<leader>tf", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, { noremap = true, silent = true, desc = "Run tests in current file" })

		vim.keymap.set("n", "<leader>tn", function()
			require("neotest").run.run()
		end, { noremap = true, silent = true, desc = "Run nearest test" })
		vim.keymap.set("n", "<leader>ta", function()
			require("neotest").run.run({ suite = true })
		end, { noremap = true, silent = true, desc = "Run all tests in suite" })

		vim.keymap.set("n", "<leader>td", function()
			require("neotest").run.stop()
		end, { noremap = true, silent = true, desc = "Stop running test" })

		vim.keymap.set("n", "<leader>to", function()
			require("neotest").output.open({ enter = true })
		end, { noremap = true, silent = true, desc = "Open test output" })

		vim.keymap.set("n", "<leader>ts", function()
			require("neotest").summary.toggle()
		end, { noremap = true, silent = true, desc = "Toggle test summary" })
	end,
}
