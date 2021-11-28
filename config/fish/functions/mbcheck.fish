function mbcheck -d "CBL-Mariner Rebuild packages given as args `with run check == Y"
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
	LOG_LEVEL=info
end

# Ofcourse fina a way to pass in an argument to the function so that, we only have mb
