return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			sections = {
				lualine_c = {
					{ function() return _G.debug_status() end },
				},
			},
		})
	end,
}
