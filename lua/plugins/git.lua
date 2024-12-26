return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed.
		"nvim-telescope/telescope.nvim", -- optional
		"ibhagwan/fzf-lua", -- optional
		"echasnovski/mini.pick", -- optional
	},
	config = function()
		require("neogit").setup({})
		local keymap = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		-- Open Neogit
		keymap("n", "<leader>gg", ":Neogit<CR>", opts) -- Open Neogit in the current directory
		keymap("n", "<leader>gs", ":Neogit status<CR>", opts) -- Open Neogit status view
		keymap("n", "<leader>gl", ":Neogit log<CR>", opts) -- Open Neogit log view
		keymap("n", "<leader>gb", ":Neogit branch<CR>", opts)
	end,
}
