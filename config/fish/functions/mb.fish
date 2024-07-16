function mb -d "CBL-Mariner Rebuild packages given as args"
	command sudo make build-packages -j12 \
	CONFIG_FILE= \
	PACKAGE_BUILD_LIST="$argv" \
	PACKAGE_REBUILD_LIST="$argv" \
	REBUILD_TOOLS=y \
	RUN_CHECK=n \
	REBUILD_DEP_CHAINS=n \
	USE_PACKAGE_BUILD_CACHE=y \
	SRPM_FILE_SIGNATURE_HANDLING=update \
	SOURCE_URL="https://cblmarinerstorage.blob.core.windows.net/sources/core" \
	PACKAGE_URL_LIST="https://cblmarinerdevrepo.blob.core.windows.net/main-latest/RPMS" \
	USE_PREVIEW_REPO=n \
	REFRESH_WORKER_CHROOT=n \
	LOG_LEVEL=info
end

