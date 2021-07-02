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
sudo apt install -y build-essential gcc git neovim fish tmux python3-pip libssl-dev exuberant-ctags pkg-config tmux
