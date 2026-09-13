function vfzfgrep -d "Vgrep on steriods"
	set --local _initial_query $argv[1]
	set --local _vgrep_prefix "$HOME/g/bin/vgrep --no-header"
	command env FZF_DEFAULT_COMMAND="$_vgrep_prefix $_initial_query" \
		fzf --bind "change:reload:$_vgrep_prefix {q} || true" --ansi --phony --tac --query "$_initial_query" \
		| awk '{print $1}' | xargs -I{} -o vgrep --show {}
end
