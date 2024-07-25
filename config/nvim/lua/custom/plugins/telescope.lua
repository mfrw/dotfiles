return {
	"nvim-lua/plenary.nvim",
	{
		"nvim-lua/telescope.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-smart-history.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("custom.telescope")
		end,
	},
}
