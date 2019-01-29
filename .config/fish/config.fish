set -gx GOROOT_BOOTSTRAP $HOME/go1.4
set -gx GOROOT $HOME/go
set -gx GOPATH $HOME/g

set CARGO $HOME/.cargo
set RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src/

set PYENV_ROOT $HOME/.pyenv

set NVM_DIR $HOME/.nvm



set FZF_DEFAULT_COMMAND 'rg --files'

alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
alias dotfiles='/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vi=nvim




set -Ux LSCOLORS "Gxfxcxdxbxegedabagacad"
set -U fish_user_paths $HOME/bin $GOROOT/bin $GOPATH/bin $CARGO/bin $PYENV_ROOT/bin
