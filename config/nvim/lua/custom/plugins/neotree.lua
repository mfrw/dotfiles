return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "main",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require("neo-tree").setup({
			window = {
				mappings = {
					["p"] = {
						function(state)
							local node = state.tree:get_node()
							require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
						end,
						desc = "Go to Parent",
					},
				},
			},
		})
	end,
}
