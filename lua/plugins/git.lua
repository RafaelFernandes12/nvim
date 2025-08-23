return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",

			"nvim-telescope/telescope.nvim",
			"ibhagwan/fzf-lua",
			"echasnovski/mini.pick",
		},
		config = function()
			require("neogit").setup({
				integrations = {
					diffview = true,
				},
			})
			local keymap = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			keymap("n", "<leader>gg", ":Neogit<CR>", opts)
			keymap("n", "<leader>gl", ":Neogit log<CR>", opts)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { noremap = true, silent = true }),
				vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", { noremap = true, silent = true }),
				vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { noremap = true, silent = true }),
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("diffview").setup({
				enhanced_diff_hl = true,
				use_icons = true,
				icons = {
					folder_closed = "",
					folder_open = "",
				},
				-- file_panel = {
				-- 	width = 35,
				-- 	use_icons = true,
				-- },
				view = {
					merge_tool = {
						layout = "diff3_mixed",
					},
				},
			})

			-- Keybindings
			vim.api.nvim_set_keymap("n", "<leader>gd", ":DiffviewOpen<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>gdc", ":DiffviewClose<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>gdh", ":DiffviewFileHistory<CR>", { noremap = true, silent = true })
		end,
	},
	{
		'akinsho/git-conflict.nvim', version = "*", config = true
	}
}
