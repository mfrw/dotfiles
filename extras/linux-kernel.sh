#!/bin/bash

echo "Cloning a whole lot of kernels"

pushd $HOME

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

if [[ $? -ne 0 ]] ; then
	echo "~/linux already exists"
	popd
	exit 1
fi

cd linux

echo "Lets add a buch of remotes"

git remote add bpf-next          git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
git remote add cb                git@github.com:microsoft/CBL-Mariner-Linux-Kernel.git
git remote add cloud-hv          git@github.com:cloud-hypervisor/linux.git
git remote add hyperv            git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
git remote add kselftest         git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
git remote add linux-block       git://git.kernel.dk/linux-block
git remote add linux-labs        git@github.com:linux-kernel-labs/linux.git
git remote add linux-next        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git remote add mingo             git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
git remote add net-next          git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git remote add pagecache         git://git.infradead.org/users/willy/pagecache.git
git remote add rust              git@github.com:Rust-for-Linux/linux.git
git remote add willy-linux       git://git.infradead.org/users/willy/linux.git
git remote add xarry             git://git.infradead.org/users/willy/xarray.git

echo "Brach out !!!"

git branch blk-nxt            linux-block/for-next    --track
git branch blk-perf-wip       linux-block/perf-wip    --track
git branch bpf-nxt            bpf-next/for-next       --track
git branch hv-fixes           hyperv/hyperv-fixes     --track
git branch hv-nxt             hyperv/hyperv-next      --track
git branch iomap              willy-linux/folio-iomap --track
git branch l-nxt              linux-next/master       --track
git branch mingo-master       mingo/master            --track
git branch n-nxt              net-next/master         --track
git branch pgc-nxt            pagecache/for-next      --track
git branch r-master           rust/rust               --track
git branch r-nxt              rust/rust-next          --track
git branch xarray-main        xarray/main             --track

popd
