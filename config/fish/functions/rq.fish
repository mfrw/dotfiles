function rq
	fd -e rpm -I | fzf --preview='rpm -q --provides {}'
end

