#!/bin/bash

if [ "$EUID" -eq 0 ]
	then echo "Please dont run as root"
	exit
fi

# clone go
pushd $HOME

git clone https://github.com/golang/go.git
# add go1.4 bootstrap
# <golang pushd>
pushd go
git worktree add $HOME/go1.4 release-branch.go1.4
# For go >= 1.19 we require atleast go1.17 (might as well use 1.18 for faster builds)
# Build the go1.18 bootstrapper using go1.4
# env GOROOT_BOOTSTRAP=$HOME/go1.4
git worktree add $HOME/go1.18 release-branch.go1.18
# </golang pushd>
popd

popd
# end -- go
