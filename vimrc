set noincsearch
set ic
set timeoutlen=300
scriptencoding utf-8
set encoding=UTF-8
set t_Co=256
set nocp
set nohls
set backspace=2
set noshowmode
syn on se title
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab
set background=dark
set nu
set cindent
set tags=./tags;
set nolist
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set maxmempattern=2000000
set hidden
"disable BCE: https://sunaku.github.io/vim-256color-bce.html
"set t_ut=
set mouse=
colorscheme torte

" Hack
"highlight default link NormalFloat Normal "fix the floating window color issue


call plug#begin('~/.vim/bundle')

Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'preservim/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'rust-lang/rust.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'
Plug 'dag/vim-fish'
Plug 'lotabout/skim'
Plug 'lotabout/skim.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'buoto/gotests-vim'

" lets go lua
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-github.nvim'

" LSP Support
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

"  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'

Plug 'junnplus/lsp-setup.nvim'


" Plugin list ends here
call plug#end()

filetype plugin on
filetype plugin indent on

" Some random mappings
au FileType go nmap <leader>r <Plug>(go-run)
au FileType * map <leader>t :TagbarToggle <CR>
au FileType * map <leader>n <plug>NERDTreeTabsToggle<CR>
map <leader>f :NERDTreeFind<CR>
map <leader>n :NERDTreeTabsToggle<CR>
map <leader>g :Git<CR>

" Rust Related Stuff
let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 0


" Tagbar

" Makefile
let g:tagbar_type_make = {
			\ 'kinds':[
			\ 'm:macros',
			\ 't:targets'
			\ ]
			\}
" UltiSnips
let g:tagbar_type_snippets = {
			\ 'ctagstype' : 'snippets',
			\ 'kinds' : [
			\ 's:snippets',
			\ ]
			\ }
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" NERDTree

let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.so$', '\.a$']


" Cope with gocode not working on VIM
let g:go_gocode_propose_source = 1

" Vim airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'


" This is from Modern VIM
" FZF Ctrl+P
nnoremap <C-p> :<C-u>Telescope find_files<CR>
if has('nvim')
       tnoremap <Esc> <C-\><C-n>
       tnoremap <C-v><Esc> <Esc>
endif

" Resumeable Rg -- override Rg
" command! -bang -nargs=* Rg :Telescope live_grep

" ==================== vim-go ====================
" go extras
let g:go_fmt_command = "goimports"

let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
\ }
let g:go_autodetect_gopath = 1
let g:go_echo_command_info = 1
let g:go_fold_enable = []
let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_list_type = "quickfix"
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_modifytags_transform = 'camelcase'
let g:go_test_prepend_name = 1


lua << EOF

require('lsp-setup').setup({
servers = {
	['rust_analyzer@nightly'] = {
		settings = {
			['rust-analyzer'] = {
				inlayHints = {
					bindingModeHints = {
						enable = false,
					},
					chainingHints = {
						enable = true,
					},
					closingBraceHints = {
						enable = true,
						minLines = 25,
					},
					closureReturnTypeHints = {
						enable = 'never',
					},
					lifetimeElisionHints = {
						enable = 'never',
						useParameterNames = false,
					},
					maxLength = 25,
					parameterHints = {
						enable = true,
					},
					reborrowHints = {
						enable = 'never',
					},
					renderColons = true,
					typeHints = {
						enable = true,
						hideClosureInitialization = false,
						hideNamedConstructor = false,
					},
				}
				},
			},
		},
		['gopls']  = {
			settings = {
				gopls = {
					hints = {
						rangeVariableTypes = true,
						parameterNames = true,
						constantValues = true,
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						functionTypeParameters = true,
						},
					},
				},
			},

		}
})


vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.keymap.set('n', '<C-]>', '<cmd>Telescope lsp_definitions<CR>', opts)
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.keymap.set('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.get()<CR>', opts)
vim.keymap.set('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
vim.keymap.set('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
vim.keymap.set('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
vim.keymap.set('n', '<space>ci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
vim.keymap.set('n', '<space>co', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)




local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

EOF
