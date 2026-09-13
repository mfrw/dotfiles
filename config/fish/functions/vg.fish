function vg
	vgrep --no-header --no-less $argv |  fzf --ansi --bind "enter:execute:nvim {2} +{3}"
end
