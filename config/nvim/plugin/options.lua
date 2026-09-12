local opt = vim.opt

----- Interesting Options -----

-- You have to turn this one on :)
opt.inccommand = "split"

-- Best search settings :)
opt.smartcase = true
opt.ignorecase = true

----- Personal Preferences -----
opt.number = true
opt.relativenumber = true

opt.splitbelow = false
opt.splitright = true

opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }

opt.clipboard = ""

-- Don't have `o` add a comment
opt.formatoptions:remove("o")
opt.mouse = ""
opt.splitbelow = true

vim.cmd.colorscheme("torte")
vim.cmd("set nosplitbelow")
vim.cmd("set noincsearch")
vim.cmd("set ic")
vim.cmd("set timeoutlen=300")
vim.cmd("set encoding=UTF-8")
vim.cmd("set nocp")
vim.cmd("set nohls")
vim.cmd("set backspace=2")
vim.cmd("set tabstop=8")
vim.cmd("syn on se title")
vim.cmd("set tabstop=8")
vim.cmd("set softtabstop=8")
vim.cmd("set shiftwidth=8")
vim.cmd("set noexpandtab")
vim.cmd("set background=dark")
vim.cmd("set nu")
vim.cmd("set cindent")
vim.cmd("set tags=./tags;")
vim.cmd("set nolist")
vim.cmd("set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣")
vim.cmd("set maxmempattern=2000000")
vim.cmd("set hidden")

-- infinte undo
vim.opt.undofile = true

-- always center search results
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "*", "*zz", { silent = true })
vim.keymap.set("n", "#", "#zz", { silent = true })
vim.keymap.set("n", "g*", "g*zz", { silent = true })

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	command = "silent! lua vim.highlight.on_yank({ timeout = 500 })",
})

-- jump to last edit position on opening file
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function(ev)
		if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
			-- except for in git commit messages
			-- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
			if not vim.fn.expand("%:p"):find(".git", 1, true) then
				vim.cmd('exe "normal! g\'\\""')
			end
		end
	end,
})

vim.diagnostic.config({ virtual_text = true })

-- trim trailing whitespace on save, preserving cursor position/view
-- (replaces bronson/vim-trailing-whitespace)
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local view = vim.fn.winsaveview()
		vim.cmd([[keeppatterns %s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})
