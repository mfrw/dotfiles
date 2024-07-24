local data = assert(vim.fn.stdpath("data")) --[[@as string]]

require("telescope").setup({
	extensions = {
		wrap_results = true,

		fzf = {},
		--    history = {
		--      path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
		--      limit = 100,
		--    },
	},
})

pcall(require("telescope").load_extension, "fzf")
-- pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files)

-- vim.keymap.set("n", "<space>fa", function()
--   ---@diagnostic disable-next-line: param-type-mismatch
--   builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy") }
-- end)
