function cmhydrate -d "CBL-Mariner Hydrate toolchain & RPMS"
	if test (count $argv) -lt 1
		echo "Give the commit #ash to hydrate"
		return
	end

	# Check if we are in a git repo
	set base (git rev-parse --show-toplevel)
	if test $status -ne 0
		echo "Not in the right place! This dir is not even a git directory; Are you sure you ain't high ?"
		return
	end

	# Check if we targetting the right place :)
	if test -e $base/toolkit/Makefile
		if test -e $base/toolkit
			pushd $base/toolkit
			git checkout $argv[1]

			echo "Clean Everything!"
			sudo make clean

			echo "Hydrate Toolchain"
			sudo make hydrate-toolchain TOOLCHAIN_ARCHIVE=$HOME/cm_arts/$argv[1]/toolchain_built_rpms_all.tar.gz TOOLCHAIN_CONTAINER_ARCHIVE=$HOME/cm_arts/$argv[1]/toolchain_from_container.tar.gz

			echo "Hydrate RPMS"
			sudo make -j(nproc) hydrate-rpms PACKAGE_ARCHIVE=$HOME/cm_arts/$argv[1]/rpms.tar.gz

			echo "Make & populate the RPM Cache"
			sudo mkdir -p ../build/rpm_cache/cache/{noarch,x86_64}
			sudo cp ../build/toolchain/built_rpms_all/*x86_64.rpm ../build/rpm_cache/cache/x86_64
			sudo cp ../build/toolchain/built_rpms_all/*noarch.rpm ../build/rpm_cache/cache/noarch
			popd
		end
		return 0
	end
end

