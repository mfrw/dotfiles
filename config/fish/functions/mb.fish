function mb -d "CBL-Mariner Rebuild packages given as args"
	command sudo make build-packages -j12 \
	CONFIG_FILE= \
	PACKAGE_BUILD_LIST="$argv" \
	PACKAGE_REBUILD_LIST="$argv" \
	REBUILD_TOOLS=y \
	RUN_CHECK=n \
	SRPM_FILE_SIGNATURE_HANDLING=update \
	SOURCE_URL="https://cblmarinerstorage.blob.core.windows.net/sources/core" \
	LOG_LEVEL=info
end

