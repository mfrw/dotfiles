function azvmgrep --description 'grep vmnames from azcli & fetch their details'
	az vm list --query='[].{name:name,id:id}' -g="" -o tsv | fzf --preview="az vm get-instance-view -o json --ids=(echo {} | choose 1)"
end
