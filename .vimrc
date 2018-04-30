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

nnoremap <F5> :GundoToggle<CR>

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/vundle'

"Plugin 'Raimondi/delimitMate'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
"Plugin 'avelino/vim-bootstrap-updater'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'dahu/LearnVim'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'honza/vim-snippets'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'majutsushi/tagbar'
"Plugin 'ludwig/split-manpage.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
"Plugin 'scrooloose/syntastic'
"Plugin 'sheerun/vim-polyglot'
Plugin 'sirver/ultisnips'
Plugin 'sjl/gundo.vim'
Plugin 'taglist.vim'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'vim-scripts/c.vim'
Plugin 'vim-scripts/grep.vim'
Plugin 'vimwiki/vimwiki'
"Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
"Plugin 'kien/ctrlp.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'pangloss/vim-javascript'

Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'corylanou/vim-present', {'for' : 'present'}
Plugin 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plugin 'elzr/vim-json', {'for' : 'json'}
Plugin 'fatih/vim-nginx' , {'for' : 'nginx'}
Plugin 'godlygeek/tabular'
Plugin 'hashivim/vim-hashicorp-tools'
Plugin 'tmux-plugins/vim-tmux', {'for': 'tmux'}

Plugin 'rhysd/vim-clang-format'
Plugin 'Rip-Rip/clang_complete'



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
