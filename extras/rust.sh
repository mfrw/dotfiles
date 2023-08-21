#!/bin/bash

if [ "$EUID" -eq 0 ]
	then echo "Please dont run as root"
	exit
fi

# install nightly rust
curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly --profile default

source "$HOME/.cargo/env"

# install rust utils
# Leverage quickinstall
cargo install cargo-quickinstall
cargo quickinstall \
	bat \
	bingrep \
	cargo-update \
	choose \
	difftastic \
	du-dust \
	dufs \
	exa \
	fd-find \
	git-delta \
	gitui \
	igrep \
	jql \
	kondo \
	ripgrep \
	samply \
	skim \
	starship \
	tealdeer \
	zoxide
