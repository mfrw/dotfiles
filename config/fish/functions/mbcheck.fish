function mbcheck -d "CBL-Mariner Rebuild packages given as args `with run check == Y"
	command sudo make build-packages -j12 \
	CONFIG_FILE= \
	REBUILD_PACKAGES=y \
	REBUILD_TOOLS=y \
	RUN_CHECK=y \
	PACKAGE_IGNORE_LIST="perl openjdk8" \
	DISABLE_UPSTREAM_REPOS=y \
	REBUILD_DEP_CHAINS=y \
	PACKAGE_BUILD_LIST="$argv" \
	PACKAGE_REBUILD_LIST="mariner-rpm-macros filesystem kernel-headers glibc zlib file binutils gmp mpfr libmpc pkg-config ncurses readline bash bzip2 gdbm coreutils gettext sqlite nspr expat grep libffi xz zstd m4 libdb libcap popt util-linux findutils tar gawk gzip lib    pipeline libtool make patch procps-ng sed nss flex libarchive diffutils mariner-release perl-DBI perl-Object-Accessor bison autoconf texinfo perl-DBD-SQLite perl-DBIx-Simple elfutils automake perl-Test-Warnings perl-Text-Template openssl wget freetype pcre which zip     unzip alsa-lib python2 lua rpm cpio kmod perl-XML-Parser libssh2 perl-libintl-perl gperf python-setuptools libgpg-error intltool check e2fsprogs libgcrypt kbd krb5 curl libxml2 cracklib cmake pam docbook-dtd-xml libxslt docbook-style-xsl shadow-utils gtest libsolv gl    ib libassuan npth libksba gnupg2 swig gpgme pinentry tdnf createrepo_c itstool gtk-doc libtasn1 ninja-build meson libpwquality json-c libsepol libselinux systemd-bootstrap libaio lvm2 cryptsetup systemd p11-kit asciidoc ca-certificates mariner-repos" \
	USE_PACKAGE_BUILD_CACHE=y \
	SRPM_FILE_SIGNATURE_HANDLING=update \
	SOURCE_URL="https://cblmarinerstorage.blob.core.windows.net/sources/core" \
	LOG_LEVEL=info
end

# Ofcourse fina a way to pass in an argument to the function so that, we only have mb
