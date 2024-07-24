-- vim.api.nvim_set_keymap("n", "ll", ":<C-U>Git commit -s<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "ll", ":<C-U>Git commit -s<CR>", { noremap = true, silent = true, buffer = true })
