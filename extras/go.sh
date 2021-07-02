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
# </golang pushd>
popd

popd
# end -- go
