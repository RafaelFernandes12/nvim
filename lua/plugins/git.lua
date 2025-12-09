return {
	{
		-- "kdheepak/lazygit.nvim",
		-- lazy = true,
		-- cmd = {
		-- 	"LazyGit",
		-- 	"LazyGitConfig",
		-- 	"LazyGitCurrentFile",
		-- 	"LazyGitFilter",
		-- 	"LazyGitFilterCurrentFile",
		-- },
		-- -- optional for floating window border decoration
		-- dependencies = {
		-- 	"nvim-lua/plenary.nvim",
		-- },
		-- -- setting the keybinding for LazyGit with 'keys' is recommended in
		-- -- order to load the plugin when the command is run for the first time
		-- keys = {
		-- 	{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
		-- },
		-- init = function()
		-- 	vim.g.lazygit_floating_window_winblend = 0
		-- 	vim.g.lazygit_floating_window_use_plenary = 1
		-- 	vim.g.lazygit_use_custom_config_file_path = 0
		-- 	vim.g.lazygit_config = nil
		-- 	-- Map <C-c> to <Esc> in terminal mode for LazyGit
		-- 	vim.api.nvim_create_autocmd("TermOpen", {
		-- 		pattern = "term://*lazygit*",
		-- 		callback = function()
		-- 			vim.api.nvim_buf_set_keymap(0, "t", "<C-c>", "<C-\\><C-n>", { noremap = true, silent = true })
		-- 		end,
		-- 	})
		-- end,

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
