function cmhydrate -d "CBL-Mariner Hydrate toolchain & RPMS"
	if test (count $argv) -lt 1
		echo "Give the commit #ash to hydrate"
		return
	end

	pushd $HOME/mariner-org/CBL-Mariner/toolkit

	git checkout $argv[1]
	sudo make -j(nproc) clean

	#cp $HOME/cm_arts/$argv[1] resources/manifests/package

	echo "Hydrate toolchain"
	sudo make -j(nproc) hydrate-toolchain \
		TOOLCHAIN_ARCHIVE=$HOME/cm_arts/$argv[1]/toolchain_built_rpms_all.tar.gz \
		TOOLCHAIN_CONTAINER_ARCHIVE=$HOME/cm_arts/$argv[1]/toolchain_from_container.tar.gz

	echo "Hydrate RPMS"
	sudo make -j(nproc) hydrate-rpms \
		PACKAGE_ARCHIVE=$HOME/cm_arts/$argv[1]/rpms.tar.gz

	echo "Hydrate COREUI RPMS"
	sudo make -j(nproc) hydrate-rpms \
		PACKAGE_ARCHIVE=$HOME/cm_arts/$argv[1]/coreui_rpms.tar.gz


	sudo mkdir -p ../build/rpm_cache/cache/{noarch,x86_64}
	sudo cp ../build/toolchain/built_rpms_all/*x86_64.rpm ../build/rpm_cache/cache/x86_64
	sudo cp ../build/toolchain/built_rpms_all/*noarch.rpm ../build/rpm_cache/cache/noarch

	popd
end

