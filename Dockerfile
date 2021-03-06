# Build stage

FROM ubuntu:18.04 AS build

ENV LANG="C.UTF-8" \
		LC_ALL="C.UTF-8"

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yy --no-install-recommends \
	autoconf \
	automake \
	autopoint \
	autotools-dev \
	binutils \
	binutils-common \
	binutils-x86-64-linux-gnu \
	bsdmainutils \
	build-essential \
	ca-certificates \
	cpp \
	cpp-7 \
	debhelper \
	dh-autoreconf \
	dh-strip-nondeterminism \
	distro-info-data \
	docbook-xml \
	docbook-xsl \
	docutils-common \
	dpkg-dev \
	g++ \
	g++-7 \
	gcc \
	gcc-7 \
	gcc-7-base \
	gettext \
	gettext-base \
	gnupg2 \
	groff-base \
	intltool-debian \
	libarchive-zip-perl \
	libasan4 \
	libatomic1 \
	libbinutils \
	libbsd0 \
	libbz2-dev \
	libc-dev-bin \
	libc6-dev \
	libcc1-0 \
	libcilkrts5 \
	libcroco3 \
	libdpkg-perl \
	libffi-dev \
	libfile-stripnondeterminism-perl \
	libgc1c2 \
	libgcc-7-dev \
	libgdbm-compat-dev \
	libgdbm-compat4 \
	libgdbm-dev \
	libgdbm5 \
	libglib2.0-0 \
	libgomp1 \
	libicu60 \
	libisl19 \
	libitm1 \
	liblsan0 \
	liblzma-dev \
	libmpc3 \
	libmpfr6 \
	libmpx2 \
	libncurses5-dev \
	libperl5.26 \
	libpipeline1 \
	libquadmath0 \
	libreadline-dev \
	libsigsegv2 \
	libsqlite3-dev \
	libssl1.0-dev \
	libstdc++-7-dev \
	libtimedate-perl \
	libtool \
	libtsan0 \
	libubsan0 \
	libxml2 \
	libxslt1.1 \
	linux-libc-dev \
	lsb-release \
	m4 \
	make \
	man-db \
	patch \
	perl \
	perl-modules-5.26 \
	po-debconf \
	sgml-base \
	sgml-data \
	tk-dev \
	uuid-dev \
	w3m \
	wget \
	xml-core \
	xsltproc \
	zlib1g-dev

ARG PYTHON_BUILD_CONFIGURE_WITH_OPENSSL=1


# Build 2.7
ARG GPG_KEY=C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF
ARG PYTHON_VERSION=2.7.17
RUN set -ex \
	\
	&& wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
	&& wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --batch --keyserver ipv4.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \
	&& { command -v gpgconf > /dev/null && gpgconf --kill all || :; } \
	&& rm -rf "$GNUPGHOME" python.tar.xz.asc \
	&& mkdir -p "/usr/src/python/${PYTHON_VERSION}" \
	&& tar -xJC "/usr/src/python/${PYTHON_VERSION}" --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz
RUN set -ex \
	\
	&& cd "/usr/src/python/${PYTHON_VERSION}" \
	&& ./configure \
		--enable-optimizations \
		--enable-option-checking=fatal \
		--enable-shared \
		--enable-unicode=ucs4 \
	&& make -j "$(nproc)"


# Build 3.4
ARG GPG_KEY=97FC712E4C024BBEA48A61ED3A5CA953F73C700D
ARG PYTHON_VERSION=3.4.10
RUN set -ex \
	\
	&& wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
	&& wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --batch --keyserver ipv4.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \
	&& { command -v gpgconf > /dev/null && gpgconf --kill all || :; } \
	&& rm -rf "$GNUPGHOME" python.tar.xz.asc \
	&& mkdir -p "/usr/src/python/${PYTHON_VERSION}" \
	&& tar -xJC "/usr/src/python/${PYTHON_VERSION}" --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz
RUN set -ex \
	\
	&& cd "/usr/src/python/${PYTHON_VERSION}" \
	&& ./configure \
		--enable-loadable-sqlite-extensions \
		--enable-option-checking=fatal \
		--enable-shared \
		--with-system-expat \
		--with-system-ffi \
	&& make -j "$(nproc)"

# Build 3.5
ARG GPG_KEY=97FC712E4C024BBEA48A61ED3A5CA953F73C700D
ARG PYTHON_VERSION=3.5.9
RUN set -ex \
	\
	&& wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
	&& wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --batch --keyserver ipv4.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \
	&& { command -v gpgconf > /dev/null && gpgconf --kill all || :; } \
	&& rm -rf "$GNUPGHOME" python.tar.xz.asc \
	&& mkdir -p "/usr/src/python/${PYTHON_VERSION}" \
	&& tar -xJC "/usr/src/python/${PYTHON_VERSION}" --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz
RUN set -ex \
	\
	&& cd "/usr/src/python/${PYTHON_VERSION}" \
	&& ./configure \
		--enable-loadable-sqlite-extensions \
		--enable-optimizations \
		--enable-option-checking=fatal \
		--enable-shared \
		--with-system-expat \
		--with-system-ffi \
		--without-ensurepip \
	&& make -j "$(nproc)" \
		# setting PROFILE_TASK makes "--enable-optimizations" reasonable: https://bugs.python.org/issue36044 / https://github.com/docker-library/python/issues/160#issuecomment-509426916
		PROFILE_TASK='-m test.regrtest --pgo \
			test_array \
			test_base64 \
			test_binascii \
			test_binhex \
			test_binop \
			test_bytes \
			test_c_locale_coercion \
			test_class \
			test_cmath \
			test_codecs \
			test_compile \
			test_complex \
			test_csv \
			test_decimal \
			test_dict \
			test_float \
			test_fstring \
			test_hashlib \
			test_io \
			test_iter \
			test_json \
			test_long \
			test_math \
			test_memoryview \
			test_pickle \
			test_re \
			test_set \
			test_slice \
			test_struct \
			test_threading \
			test_time \
			test_traceback \
			test_unicode \
		'

# Build 3.6
ARG GPG_KEY=0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D
ARG PYTHON_VERSION=3.6.10
RUN set -ex \
	\
	&& wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
	&& wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --batch --keyserver ipv4.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \
	&& { command -v gpgconf > /dev/null && gpgconf --kill all || :; } \
	&& rm -rf "$GNUPGHOME" python.tar.xz.asc \
	&& mkdir -p "/usr/src/python/${PYTHON_VERSION}" \
	&& tar -xJC "/usr/src/python/${PYTHON_VERSION}" --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz
RUN set -ex \
	\
	&& cd "/usr/src/python/${PYTHON_VERSION}" \
	&& ./configure \
		--enable-loadable-sqlite-extensions \
		--enable-optimizations \
		--enable-option-checking=fatal \
		--enable-shared \
		--with-system-expat \
		--with-system-ffi \
		--without-ensurepip \
	&& make -j "$(nproc)" \
		# setting PROFILE_TASK makes "--enable-optimizations" reasonable: https://bugs.python.org/issue36044 / https://github.com/docker-library/python/issues/160#issuecomment-509426916
		PROFILE_TASK='-m test.regrtest --pgo \
			test_array \
			test_base64 \
			test_binascii \
			test_binhex \
			test_binop \
			test_bytes \
			test_c_locale_coercion \
			test_class \
			test_cmath \
			test_codecs \
			test_compile \
			test_complex \
			test_csv \
			test_decimal \
			test_dict \
			test_float \
			test_fstring \
			test_hashlib \
			test_io \
			test_iter \
			test_json \
			test_long \
			test_math \
			test_memoryview \
			test_pickle \
			test_re \
			test_set \
			test_slice \
			test_struct \
			test_threading \
			test_time \
			test_traceback \
			test_unicode \
		'

# Build 3.7
ARG GPG_KEY=0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D
ARG PYTHON_VERSION=3.7.7
RUN set -ex \
	\
	&& wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
	&& wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --batch --keyserver ipv4.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \
	&& { command -v gpgconf > /dev/null && gpgconf --kill all || :; } \
	&& rm -rf "$GNUPGHOME" python.tar.xz.asc \
	&& mkdir -p "/usr/src/python/${PYTHON_VERSION}" \
	&& tar -xJC "/usr/src/python/${PYTHON_VERSION}" --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz
RUN set -ex \
	\
	&& cd "/usr/src/python/${PYTHON_VERSION}" \
	&& ./configure \
		--enable-optimizations \
	&& make -j "$(nproc)" \
		# setting PROFILE_TASK makes "--enable-optimizations" reasonable: https://bugs.python.org/issue36044 / https://github.com/docker-library/python/issues/160#issuecomment-509426916
		PROFILE_TASK='-m test.regrtest --pgo \
			test_array \
			test_base64 \
			test_binascii \
			test_binhex \
			test_binop \
			test_bytes \
			test_c_locale_coercion \
			test_class \
			test_cmath \
			test_codecs \
			test_compile \
			test_complex \
			test_csv \
			test_decimal \
			test_dict \
			test_float \
			test_fstring \
			test_hashlib \
			test_io \
			test_iter \
			test_json \
			test_long \
			test_math \
			test_memoryview \
			test_pickle \
			test_re \
			test_set \
			test_slice \
			test_struct \
			test_threading \
			test_time \
			test_traceback \
			test_unicode \
		'

# Build 3.8
ARG GPG_KEY=E3FF2839C048B25C084DEBE9B26995E310250568
ARG PYTHON_VERSION=3.8.2
RUN set -ex \
	\
	&& wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
	&& wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --batch --keyserver ipv4.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \
	&& { command -v gpgconf > /dev/null && gpgconf --kill all || :; } \
	&& rm -rf "$GNUPGHOME" python.tar.xz.asc \
	&& mkdir -p "/usr/src/python/${PYTHON_VERSION}" \
	&& tar -xJC "/usr/src/python/${PYTHON_VERSION}" --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz
RUN set -ex \
	\
	&& cd "/usr/src/python/${PYTHON_VERSION}" \
	&& ./configure \
		--enable-loadable-sqlite-extensions \
		--enable-optimizations \
		--enable-option-checking=fatal \
		--enable-shared \
		--with-system-expat \
		--with-system-ffi \
		--without-ensurepip \
	&& make -j "$(nproc)"

RUN mv /usr/local $HOME/backup-local
RUN find /usr/src/python -maxdepth 1 -mindepth 1 -type d -exec make altinstall -C {} \;
RUN tar czf snakes.tar.gz /usr/local

# Release stage

FROM ubuntu:18.04

COPY --from=build snakes.tar.gz .
RUN tar xf snakes.tar.gz && rm -rf snakes.tar.gz

ENV LANG="C.UTF-8"

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yy --no-install-recommends \
	ca-certificates \
	file \
	libexpat1 \
	libmagic-mgc \
	libmagic1 \
	libmpdec2 \
	libreadline7 \
	libsqlite3-0 \
	libssl1.0 \
	mime-support \
	readline-common \
	xz-utils
