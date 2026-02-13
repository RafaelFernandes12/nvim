return {
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
		'akinsho/git-conflict.nvim', version = "*", config = true
	}
}
