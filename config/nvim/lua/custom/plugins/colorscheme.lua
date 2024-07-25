return {
	{
		"tjdevries/colorbuddy.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("gruvbuddy")
		end,
	},

	{ "rose-pine/neovim", name = "rose-pine" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{
		"maxmx03/fluoromachine.nvim",
		-- config = function()
		--   local fm = require "fluoromachine"
		--   fm.setup { glow = true, theme = "fluoromachine" }
		-- end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			vim.cmd.colorscheme("gruvbox")
		end,
	},
}
