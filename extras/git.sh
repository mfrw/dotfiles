#!/bin/bash

if [ "$EUID" -eq 0 ]
	then echo "Please dont run as root"
	exit
fi

sudo add-apt-repository -y ppa:git-core/ppa
sudo apt update
