function psc -d "better ps"
	ps xawf -eo pid,user,cgroup,args
end
