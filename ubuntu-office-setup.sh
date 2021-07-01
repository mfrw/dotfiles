#!/bin/bash

# always ensure this is run from the $HOME dir

pushd $HOME

# add fish ppa
sudo apt-add-repository -y ppa:fish-shell/release-3
# add neovim 0.5-dev ppa
sudo apt-add-repository -y ppa:neovim-ppa/unstable

# install nightly rust
curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly

source "$HOME/.cargo/env"

# install rust utils

cargo install bat bingrep cargo-edit cargo-update choose du-dust exa fd-find git-delta gitui gpg-tui hyperfine jql lsd ripgrep skim tealdeer


# install build-essential git gcc

sudo apt update
sudo apt install -y build-essential gcc git neovim fish tmux python3-pip
pip3 install neovim

# clone go

git clone https://github.com/golang/go.git

# add go1.4 bootstrap
# <golang pushd>
pushd go
git worktree add $HOME/go1.4 release-branch.go1.4
popd
# </golang pushd>

# install vim-plug for nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# link vimrc to $HOME/.vimrc
ln -s $(pwd)/vimrc $HOME/.vimrc
# link vimrc to $HOME/.config/nvim/init.vim
mkdir -p $HOME/.config/nvim/
ln -s $(pwd)/vimrc $HOME/.config/nvim/init.vim
# link tmux.conf -> $HOME/.tmux.conf
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf

# install fisher
# curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fish configure.fish

popd
