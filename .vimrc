syntax enable
set nocp
set backspace=2
"set noshowmode
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
Plug 'fatih/vim-go'
Plug 'honza/vim-snippets'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
"Plugin 'ludwig/split-manpage.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'scrooloose/syntastic'
"Plugin 'sheerun/vim-polyglot'
Plug 'sirver/ultisnips'
Plug 'sjl/gundo.vim'
Plug 'vim-scripts/taglist.vim'
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
"Plugin 'Rip-Rip/clang_complete'
Plug 'lervag/vimtex'
"Plugin 'nathanaelkane/vim-indent-guides'

" Plugin list ends here
call plug#end()



filetype plugin on
filetype plugin indent on

" GO Related Stuff
let g:go_fmt_command = 'goimports'
let g:go_info_mode = 'guru'



" Some random mappings
au FileType go nmap <leader>r <Plug>(go-run)
au FileType * map <leader>t :TagbarToggle <CR>
map <leader>n <plug>NERDTreeTabsToggle<CR>
"au FileType * map <leader>n :NERDTreeToggle <CR>


" Dont autosave
:let g:session_autosave = 'no'



" Rust Related Stuff
let g:rustfmt_autosave = 1


" Syntastic Recommended Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" clang-format
autocmd FileType c,cpp,java ClangFormatAutoEnable
"let g:clang_library_path='/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'


" Tagbar

" Rust
let g:tagbar_type_rust = {
			\ 'ctagstype' : 'rust',
			\ 'kinds' : [
			\'T:types,type definitions',
			\'f:functions,function definitions',
			\'g:enum,enumeration names',
			\'s:structure names',
			\'m:modules,module names',
			\'c:consts,static constants',
			\'t:traits',
			\'i:impls,trait implementations',
			\]
			\}
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

" NERDTree

let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.so$', '\.a$']


" Cope with gocode not working on VIM
let g:go_gocode_propose_source = 1
