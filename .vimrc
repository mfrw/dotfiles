syntax enable
set noincsearch
set timeoutlen=300
scriptencoding utf-8
set encoding=UTF-8
"set scrolloff=2
set nocp
set nohls
set backspace=2
set noshowmode
"syn on se title
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab
set background=dark
set nu
set cindent
set tags=./tags;
set t_Co=256
set nolist
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set maxmempattern=2000000

" Avoid Bad habits
nnoremap <Left> :echoe "Bad Habit: Use h"<CR>
nnoremap <Right> :echoe "Bad Habit: Use l"<CR>
nnoremap <Up> :echoe "Bad Habit: Use k"<CR>
nnoremap <Down> :echoe "Bad Habit: Use j"<CR>

" nnoremap <F5> :GundoToggle<CR>

call plug#begin('~/.vim/bundle')

"filetype off
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
"Plugin 'gmarik/vundle'

"Plugin 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
"Plugin 'avelino/vim-bootstrap-updater'
Plug 'bronson/vim-trailing-whitespace'
Plug 'dahu/LearnVim'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'honza/vim-snippets'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
"Plugin 'ludwig/split-manpage.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
"Plugin 'vim-syntastic/syntastic'
"Plug 'scrooloose/syntastic'
"Plugin 'sheerun/vim-polyglot'
Plug 'sirver/ultisnips'
Plug 'sjl/gundo.vim'
"Plug 'vim-scripts/taglist.vim'
Plug 'tomasr/molokai'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plugin 'vim-scripts/c.vim'
Plug 'vim-scripts/grep.vim'
"Plugin 'vimwiki/vimwiki'
"Plugin 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
"Plugin 'kien/ctrlp.vim'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'corylanou/vim-present', {'for' : 'present'}
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'fatih/vim-nginx' , {'for' : 'nginx'}
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}

Plug 'rhysd/vim-clang-format'
"Plug 'Rip-Rip/clang_complete'
Plug 'lervag/vimtex'
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'rking/ag.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jceb/vim-orgmode'
Plug 'mattn/emmet-vim'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-unimpaired'
" Plug 'ryanoasis/vim-devicons'
"Plug 'racer-rust/vim-racer'
Plug 'easymotion/vim-easymotion'
Plug 'dag/vim-fish'
"Plug 'Shougo/echodoc.vim'
"Plug 'autozimu/LanguageClient-neovim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
"if has('nvim-disable')
"	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"	Plug 'deoplete-plugins/deoplete-go'
"	Plug 'deoplete-plugins/deoplete-clang'
"	let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
"	let g:deoplete#enable_at_startup = 0
"endif
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" vim-maktaba
Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'
Plug 'google/vim-codefmt'
Plug 'google/vim-selector'
Plug 'google/vim-coverage'
Plug 'google/vim-syncopate'
Plug 'google/vim-codereview'
Plug 'lotabout/skim'
Plug 'lotabout/skim.vim'
Plug 'dense-analysis/ale'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'chazy/cscope_maps'

" Plugin list ends here
call plug#end()

autocmd BufReadPost *.rs setlocal filetype=rust

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'beta', 'rls'],
      "\ 'c' : ['clangd', '--resource-dir=','/Users/mfrw/clang9/'],
      "\ 'cpp' : ['clangd', '--resource-dir=','/Users/mfrw/clang9/'],
      \ 'python' : ['pyls'],
      "\ 'go' : ['gopls'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Maps K to hover, gd to goto definition, F2 to rename
"nnoremap <silent> K :call LanguageClient_textDocument_hover()



filetype plugin on
filetype plugin indent on

"" GO Related Stuff
"let g:go_fmt_command = 'goimports'
"let g:go_info_mode = 'guru'



" Some random mappings
au FileType go nmap <leader>r <Plug>(go-run)
au FileType * map <leader>t :TagbarToggle <CR>
au FileType * map <leader>n <plug>NERDTreeTabsToggle<CR>
map <leader>f :NERDTreeFind<CR>
map <leader>n :NERDTreeTabsToggle<CR>
map <leader>g :Gstatus<CR>
"au FileType * map <leader>n :NERDTreeToggle <CR>


" Dont autosave
:let g:session_autosave = 'no'



" Rust Related Stuff
let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 0


" Syntastic Recommended Settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']

" clang-format
" autocmd FileType c,cpp,java ClangFormatAutoEnable
let g:clang_format#auto_format=1
"let g:clang_library_path='/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:clang_library_path='/Users/mfrw/clang9/lib'
let g:clang_complete_auto=0


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
"nnoremap <C-p> :<C-u>FZF<CR>
"if has('nvim')
	"tnoremap <Esc> <C-\><C-n>
	"tnoremap <C-v><Esc> <Esc>
"endif
nnoremap <C-p> :<C-u>SK<CR>
if has('nvim')
       tnoremap <Esc> <C-\><C-n>
       tnoremap <C-v><Esc> <Esc>
endif

"" From faith/dotfiles
" ==================== vim-go ====================
"let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"

let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
\ }


let g:go_test_prepend_name = 1
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 0
let g:go_auto_sameids = 0
"let g:go_info_mode = "gocode"

"let g:go_def_mode = "guru"
let g:go_echo_command_info = 1
let g:go_autodetect_gopath = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 0
let g:go_highlight_operators = 1
let g:go_highlight_format_strings = 0
let g:go_highlight_function_calls = 0

let g:go_modifytags_transform = 'camelcase'
let g:go_fold_enable = []

"" Permanent Undo
"set undodir=~/.vim/vimdid
"set undofile


"" Rust
"let g:racer_experimental_completer = 1
set hidden
"autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
"autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
"autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
"au FileType rust nmap gd <Plug>(rust-def)
"au FileType rust nmap gs <Plug>(rust-def-split)
"au FileType rust nmap gx <Plug>(rust-def-vertical)
"au FileType rust nmap <leader>gd <Plug>(rust-doc)

" go extras
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
"let g:go_highlight_fields = 1
"let g:go_highlight_functions = 1
"let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
"let g:go_auto_sameids = 1
"let g:go_auto_type_info = 1
"highlight ColorColumn ctermbg=8
"set colorcolumn=80



" Rust
let $RUST_BACKTRACE = 1
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')
function LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
    nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
  endif
endfunction

autocmd FileType * call LC_maps()
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
