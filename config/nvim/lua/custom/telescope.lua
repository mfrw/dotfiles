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

-- Telescope

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = ":Telescope find_files" })
vim.keymap.set("n", "<space>lg", builtin.live_grep, { desc = ":Telescope live_grep" })
vim.keymap.set("n", "<space>tr", builtin.resume, { desc = ":Telescope resume" })
vim.keymap.set("n", "<space>tbc", builtin.git_bcommits, { desc = ":Telescope git_bcommits" })
vim.keymap.set("n", "<space>tbr", builtin.git_branches, { desc = ":Telescope git_branches" })
vim.keymap.set("n", "<space>tg", builtin.grep_string, { desc = ":Telescope grep_string" })
