#!/bin/bash

# add fish ppa
sudo apt-add-repository -y ppa:fish-shell/release-3
# add neovim 0.5-dev ppa
sudo apt-add-repository -y ppa:neovim-ppa/unstable

# install build-essential git gcc
sudo apt update
sudo apt install -y build-essential gcc git neovim fish tmux python3-pip
