#!/bin/bash

if [ "$EUID" -eq 0 ]
	then echo "Please dont run as root"
	exit
fi

# install nightly rust
curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly --profile default

source "$HOME/.cargo/env"

# install rust utils
cargo install bat cargo-edit cargo-update choose du-dust fd-find git-delta ripgrep skim tealdeer zoxide starship gitui
