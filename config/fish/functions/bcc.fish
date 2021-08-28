function bcc
	command clang -O2 -fno-stack-protector -emit-llvm -c $argv[1] -o - | \
	llc -march=bpf -filetype=obj -o (basename $argv[1] .c).o
end
