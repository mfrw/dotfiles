function bb -d "Buddy Build stuff"
	set --local options 'h/help' 'r/refresh' 'c/check'  'd/dryrun' 'f/force' 'n/nukeall' 'p/package=' 's/specs='

	argparse $options -- $argv
	if test $status -ne 0
		echo ""
		echo "TRY --help"
		echo "Exiting ..."
		return 1
	end

	if set --query _flag_help
		echo ""
		echo "Build a specific RPM using the default toolkit of CBL-Mariner-2.0:"
		echo ""
		echo "	-h/--help     : Print detailed usage"
		echo "	-s/--specs    : Spec Dir [Default SPECS]"
		echo "	-c/--check    : Run with check distabled/enabled [Default RUN_CHECK=n]"
		echo "	-p/--package  : Package to build/rebuild [Default all]"
		echo "	-r/--refresh  : Refresh worker chroot [Default false]"
		echo "	-f/--force    : Force a rebuild"
		echo "	-n/--nukeall  : Cleanup input-srpms expand-srpms"
		echo "	-d/--dryrun   : Show the command to be executed."
		echo ""
		echo ""
		echo "HACK:"
		echo "     If anything fails try this hack:"
		echo "     `git checkout -f 2.0-stable` & build vim."
		echo "     `bb -s path/to/SPECS -p vim` & then switch branch"
		echo ""
		return 0
	end

	set --query _flag_package; or set --local _flag_package ""

	if set --query _flag_force; or set --local _flag_force y
		set _flag_force n
	end

	set --query _flag_specs; or set --local _flag_specs ../SPECS;

	if set --query _flag_check; or set --local _flag_check n
		set _flag_check y
	end

	if set --query _flag_refresh; or set --local _flag_refresh n
		set _flag_refresh y
	end

	if set --query _flag_dryrun
		if set --query _flag_nukeall
			echo sudo make clean-expand-specs clean-input-srpms
		end

		echo make build-packages \
			CONFIG_FILE= \
			REBUILD_TOOLS=y \
			SOURCE_URL="https://cblmarinerstorage.blob.core.windows.net/sources/core" \
			SPECS_DIR=$_flag_specs \
			REPO_LIST=\"../SPECS/mariner-repos/mariner-official-base.repo ../SPECS/mariner-repos/mariner-extended.repo\" \
			RUN_CHECK=$_flag_check \
			REFRESH_WORKER_CHROOT=$_flag_refresh \
			SRPM_FILE_SIGNATURE_HANDLING=update \
			USE_PACKAGE_BUILD_CACHE=$_flag_force \
			SRPM_PACK_LIST=$_flag_package \
			DELTA_BUILD=y \
			$argv
		return 0
	end

	if set --query _flag_nukeall
		command sudo make clean-expand-specs clean-input-srpms
	end

	command sudo make build-packages \
		CONFIG_FILE= \
		REBUILD_TOOLS=y \
		SOURCE_URL="https://cblmarinerstorage.blob.core.windows.net/sources/core" \
		SPECS_DIR=$_flag_specs \
		REPO_LIST="../SPECS/mariner-repos/mariner-official-base.repo ../SPECS/mariner-repos/mariner-extended.repo" \
		RUN_CHECK=$_flag_check \
		REFRESH_WORKER_CHROOT=$_flag_refresh \
		SRPM_FILE_SIGNATURE_HANDLING=update \
		USE_PACKAGE_BUILD_CACHE=$_flag_force \
		SRPM_PACK_LIST="$_flag_package" \
		DELTA_BUILD=y \
		$argv
end
