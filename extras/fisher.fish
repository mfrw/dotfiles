#!/bin/fish


if fish_is_root_user
	echo "Please do not run as root user"
	exit
end

# install fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher install jorgebucaran/fisher
fisher install jethrokuan/z
fisher install jethrokuan/fzf
fisher install wfxr/forgit
