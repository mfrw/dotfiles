set -gx GOROOT_BOOTSTRAP $HOME/go1.4
set -gx GOROOT $HOME/go
set -gx GOPATH $HOME/g
set -gx LC_ALL en_US.UTF-8

set CARGO $HOME/.cargo
set RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src/

set -gx PYENV_ROOT (pyenv root)

set NVM_DIR $HOME/.nvm



set FZF_DEFAULT_COMMAND 'rg --files'

alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
alias dotfiles='/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vi=nvim
alias zc='z -c'      # restrict matches to subdirs of $PWD
alias zz='z -i'      # cd with interactive selection
alias zf='z -I'      # use fzf to select in multiple matches
alias zb='z -b'      # quickly cd to the parent directory



set -Ux LSCOLORS "Gxfxcxdxbxegedabagacad"
set -U fish_user_paths $HOME/bin $GOPATH/bin $GOROOT/bin $CARGO/bin $PYENV_ROOT/bin

# Colored man
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline<Paste>
