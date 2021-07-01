#!/bin/bash

if [ "$EUID" -eq 0 ]
	then echo "Please dont run as root"
	exit
fi


# add fish ppa
sudo apt-add-repository -y ppa:fish-shell/release-3
# add neovim 0.5-dev ppa
sudo apt-add-repository -y ppa:neovim-ppa/unstable

# install build-essential git gcc
sudo apt update
sudo apt install -y build-essential gcc git neovim fish tmux python3-pip libssl-dev exuberant-ctags pkg-config

# install neovim python deps
pip3 install neovim --user

# install nightly rust
curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly --profile default

source "$HOME/.cargo/env"

# install vim-plug for nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# clone go
pushd $HOME

git clone https://github.com/golang/go.git
# add go1.4 bootstrap
# <golang pushd>
pushd go
git worktree add $HOME/go1.4 release-branch.go1.4
# </golang pushd>
popd

popd
# end -- go

# install rust utils
cargo install bat cargo-edit cargo-update choose du-dust fd-find git-delta ripgrep skim tealdeer


