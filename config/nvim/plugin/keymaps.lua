local set = vim.keymap.set

set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- Toggle hlsearch if it's on, otherwise just do "enter"
set("n", "<CR>", function()
	---@diagnostic disable-next-line: undefined-field
	if vim.opt.hlsearch:get() then
		vim.cmd.nohl()
		return ""
	else
		return "<CR>"
	end
end, { expr = true })

-- There are builtin keymaps for this now, but I like that it shows
-- the float when I navigate to the error - so I override them.
set("n", "]d", vim.diagnostic.goto_next)
set("n", "[d", vim.diagnostic.goto_prev)

-- These mappings control the size of splits (height/width)
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<C-W>+")
set("n", "<M-s>", "<C-W>-")

set("n", "<M-j>", function()
	if vim.opt.diff:get() then
		vim.cmd([[normal! ]c]])
	else
		vim.cmd([[m .+1<CR>==]])
	end
end)

set("n", "<M-k>", function()
	if vim.opt.diff:get() then
		vim.cmd([[normal! [c]])
	else
		vim.cmd([[m .-2<CR>==]])
	end
end)

-- NeoTree
set("n", "<leader>n", "<cmd>:Neotree toggle<CR>", { desc = "Open Neotree" })
set("n", "<leader>f", "<cmd>:Neotree reveal<CR>", { desc = "Reveal File in Neotree" })

-- Fugitive
set("n", "<leader>g", "<cmd>:Git<CR>", { desc = "Open Fugitive Git" })
set("n", "<leader>t", "<cmd>:TagbarToggle<CR>", { desc = "Open Tagbar" })
set("n", "cc", ":<C-U>Git commit -s<CR>", { desc = "Commit with signoff" })

-- Telescope
local telescope_builtin = require("telescope.builtin")
set("n", "<space>lg", telescope_builtin.live_grep, { desc = "Live Grep" })
