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
set t_ut=

" Hack
highlight default link NormalFloat Normal "fix the floating window color issue


call plug#begin('~/.vim/bundle')

Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'honza/vim-snippets'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'preservim/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sirver/ultisnips'
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
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-github.nvim'


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



" LUA  starts HERE!

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>Telescope lsp_code_actions<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<space>ci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
  buf_set_keymap('n', '<space>co', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'rust_analyzer', 'gopls', 'clangd' }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		settings = {
			["rust-analyzer"] = {
				callInfo = {
					full = true
					},
				assist = {
					importGranularity = "module",
					importPrefix = "by_self",
					},
				cargo = {
					loadOutDirsFromCheck = true,
					allFeatures = true,
					},
				},
			},
		flags = {
			debounce_text_changes = 350,
			},
		}
end
EOF

" Tree-Sitter Configs
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
}
EOF



" Telescope plugins
lua << EOF
require('telescope').load_extension('gh')
EOF

lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        update_in_insert = true,
    }
)

EOF

autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"}}
