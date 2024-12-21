return {
	"f-person/git-blame.nvim",
	-- load the plugin at startup
	event = "VeryLazy",
	opts = {
		enabled = true,
		message_template = " <summary> • <date> • <author> • <<sha>>",
		date_format = "%m-%d-%Y %H:%M:%S",
		virtual_text_column = 1,
	},
	config = function()
		vim.keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", { desc = "Git Toggle Git Blame" })
		vim.keymap.set("n", "<leader>gs", "<cmd>GitBlameOpenCommitURL<CR>", { desc = "Git Show Commit URL" })
		vim.keymap.set("n", "<leader>gc", "<cmd>GitBlameCopySHA<CR>", { desc = "Git Copy Commit SHA" })
	end,
}
