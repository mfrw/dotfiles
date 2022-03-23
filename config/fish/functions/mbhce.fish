function mbhce -d "CBL-Mariner Rebuild packages given as args with RUN_CHECK=y for the SPECS-EXTENDED"
	command sudo make build-packages -j12 \
	CONFIG_FILE= \
	PACKAGE_BUILD_LIST="$argv" \
	PACKAGE_REBUILD_LIST="$argv" \
	REBUILD_TOOLS=y \
	RUN_CHECK=y \
	REBUILD_DEP_CHAINS=n \
	USE_PACKAGE_BUILD_CACHE=y \
	SRPM_FILE_SIGNATURE_HANDLING=update \
	SOURCE_URL="https://cblmarinerstorage.blob.core.windows.net/sources/core" \
	USE_PREVIEW_REPO=n \
	REFRESH_WORKER_CHROOT=n \
	HYDRATED_BUILD=y \
	SPECS_DIR=(dirname (pwd))/SPECS-EXTENDED \
	LOG_LEVEL=info
end

