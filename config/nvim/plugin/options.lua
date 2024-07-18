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

opt.clipboard = "unnamedplus"

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
