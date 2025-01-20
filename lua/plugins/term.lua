return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			direction = "float",
		})

		-- Corrected mapping for ToggleTerm command
		vim.keymap.set({ "n", "t" }, "<C-p>", function()
			vim.cmd("ToggleTerm") -- Call ToggleTerm command
		end, { noremap = true, silent = true })

		-- Keymap for exit terminal mode
		vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

		-- Keymap for switching to float direction
		vim.keymap.set({ "n", "t" }, "<C-_>", "<Cmd>ToggleTerm direction=float<CR>", { noremap = true, silent = true })
	end,
}
