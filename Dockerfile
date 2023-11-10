FROM dburianov/ubuntu:latest AS base
LABEL maintainer="Dmytro Burianov <dmytro@burianov.net>"
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Europe/London
RUN <<EOT
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
    echo $TZ > /etc/timezone
EOT
RUN <<EOT
    echo "Install packages to base"
    set -e
    apt-get update
    apt-get install -y -qy --no-install-recommends --no-install-suggests \
        xxd
    rm -rf /var/lib/apt/lists/*
    rm -rf /usr/share/doc/*
    rm -rf /usr/share/man/*
    apt-get autoremove -y
    apt-get clean -y
EOT

FROM base AS prebuild
LABEL maintainer="Dmytro Burianov <dmytro@burianov.net>"
RUN <<EOT
    echo "Install packages to pre build"
    set -e
    apt-get -yqq update
    apt-get install -y --no-install-recommends --no-install-suggests \
        git unzip libxml2-dev libbz2-dev libcurl4-openssl-dev libmcrypt-dev libmhash2 \
        libmhash-dev libpcre3 libpcre3-dev make build-essential libxslt1-dev libgeoip-dev \
        libpam-dev libgoogle-perftools-dev lua5.1 liblua5.1-0 \
        liblua5.1-0-dev checkinstall wget libssl-dev mercurial meld \
        autoconf automake cmake libass-dev libfreetype6-dev \
        libsdl2-dev libtheora-dev libtool libva-dev libvdpau-dev \
        libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev \
        texinfo zlib1g-dev pkgconf libyajl-dev libpcre++-dev liblmdb-dev \
        gettext gnupg2 curl python3 jq ca-certificates gcc g++ \
        libxslt-dev libgd-dev libperl-dev gperf uthash-dev \
        python3-pip libx265-dev libnuma-dev zstd libzstd-dev ninja-build
    pip3 install --user meson
    rm -rf /var/lib/apt/lists/*
    rm -rf /usr/share/doc/*
    rm -rf /usr/share/man/*
    apt-get autoremove -y
    apt-get clean -y
EOT

FROM prebuild AS build
ARG        PREFIX=/usr/ffmpeg_build
ARG        SRC_BASE_DIR=/usr/src/ffmpeg_sources
ARG        PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig
ARG        LD_LIBRARY_PATH=/usr/local/lib

ENV         LAME_VERSION=3.100        \
            LIBASS_VERSION=0.17.1     \
            OGG_VERSION=1.3.4         \
            OPENCOREAMR_VERSION=0.1.6 \
            THEORA_VERSION=1.1.1      \
            VORBIS_VERSION=1.3.7      \
            WEBP_VERSION=1.3.0        \
            XVID_VERSION=1.3.7        \
            OPENJPEG_VERSION=2.5.0    \
            FREETYPE_VERSION=2.10.4   \
            FRIBIDI_VERSION=0.19.7    \
            FONTCONFIG_VERSION=2.14.2 \
            LIBVIDSTAB_VERSION=1.1.0  \
            KVAZAAR_VERSION=2.2.0     \
            NASM_VERSION=2.16.01      \
            LIBSRT_VERSION=1.5.1      \
            LIBZMQ_VERSION=4.3.4      \
            LIBBLURAY_VERSION=1.3.4   \
            LIBXML2_VERSION=2.10.4

RUN <<EOT
    echo "Compiling libwebp"
    set -e
    mkdir -p ${SRC_BASE_DIR} /usr/src/bin
    cd ${SRC_BASE_DIR}
    wget https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-${WEBP_VERSION}.tar.gz
    tar -xzf libwebp-${WEBP_VERSION}.tar.gz
    cd libwebp-${WEBP_VERSION}
    ./configure --enable-shared
    make -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling openjpeg"
    set -e
    mkdir -p ${SRC_BASE_DIR} /usr/src/bin
    cd ${SRC_BASE_DIR}
    wget https://github.com/uclouvain/openjpeg/archive/v${OPENJPEG_VERSION}.tar.gz
    tar -xzf v${OPENJPEG_VERSION}.tar.gz
    cd openjpeg-${OPENJPEG_VERSION}
    #cmake -DBUILD_THIRDPARTY:BOOL=ON .
    cmake -DCMAKE_BUILD_TYPE=Release .
    make -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling opencore-amr"
    set -e
    mkdir -p ${SRC_BASE_DIR} /usr/src/bin
    cd ${SRC_BASE_DIR}
    wget https://netcologne.dl.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-${OPENCOREAMR_VERSION}.tar.gz
    tar -xzf opencore-amr-${OPENCOREAMR_VERSION}.tar.gz
    cd opencore-amr-${OPENCOREAMR_VERSION}
    ./configure --enable-shared
    make -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling nasm"
    set -e
    mkdir -p ${SRC_BASE_DIR} /usr/src/bin
    cd ${SRC_BASE_DIR}
    wget https://www.nasm.us/pub/nasm/releasebuilds/${NASM_VERSION}/nasm-${NASM_VERSION}.tar.bz2
    tar xjvf nasm-${NASM_VERSION}.tar.bz2
    cd nasm-${NASM_VERSION}
    ./autogen.sh
    PATH="/usr/bin:$PATH" ./configure --bindir="/usr/bin"
    make -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling yasm"
    set -e
    cd ${SRC_BASE_DIR}
    wget -O yasm-1.3.0.tar.gz https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
    tar xzvf yasm-1.3.0.tar.gz
    cd yasm-1.3.0
    ./configure --bindir="/usr/bin"
    make -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling x264"
    set -e
    cd ${SRC_BASE_DIR}
    git clone --depth 1 https://code.videolan.org/videolan/x264
    cd x264
    PATH="/usr/bin:$PATH" PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig" ./configure --bindir="/usr/bin" --enable-static
    PATH="/usr/bin:$PATH" make -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling x265"
    set -e
    cd ${SRC_BASE_DIR}
    git clone --depth 1 https://bitbucket.org/multicoreware/x265_git
    cd x265_git/build/linux
    PATH="/usr/bin:$PATH" PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="${PREFIX}" -DENABLE_SHARED:bool=off ../../source
    PATH="/usr/bin:$PATH" make -j$(nproc)
    make install
EOT

RUN <<EOT
    cd ${SRC_BASE_DIR}
    set -e
    wget https://downloads.xiph.org/releases/ogg/libogg-${OGG_VERSION}.tar.gz
    tar -xzf libogg-${OGG_VERSION}.tar.gz
    cd libogg-${OGG_VERSION}
    ./configure --enable-shared
    make -j$(nproc)
    make install
EOT

RUN <<EOT
    cd ${SRC_BASE_DIR}
    set -e
    wget https://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS_VERSION}.tar.gz
    tar -xzf libvorbis-${VORBIS_VERSION}.tar.gz
    cd libvorbis-${VORBIS_VERSION}
    ./configure --with-ogg="${PREFIX}" --enable-shared
    make -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling libvpx"
    set -e
    cd ${SRC_BASE_DIR}
    git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git
    cd libvpx
    PATH="/usr/bin:$PATH" ./configure --disable-examples --disable-unit-tests --enable-vp9-highbitdepth --as=yasm
    PATH="/usr/bin:$PATH" make -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling fdkaac"
    set -e
    cd ${SRC_BASE_DIR}
    git clone --depth 1 https://github.com/mstorsjo/fdk-aac
    cd fdk-aac
    autoreconf -fiv
    ./configure --disable-shared
    make -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling lame"
    set -e
    cd ${SRC_BASE_DIR}
    wget -O lame-${LAME_VERSION}.tar.gz https://downloads.sourceforge.net/project/lame/lame/${LAME_VERSION}/lame-${LAME_VERSION}.tar.gz
    tar xzvf lame-${LAME_VERSION}.tar.gz
    cd lame-${LAME_VERSION}
    PATH="/usr/bin:$PATH" ./configure --bindir="/usr/bin" --disable-shared --enable-nasm
    PATH="/usr/bin:$PATH" make -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling opus"
    set -e
    cd ${SRC_BASE_DIR}
    git clone --depth 1 https://github.com/xiph/opus.git
    cd opus
    ./autogen.sh
    ./configure --disable-shared
    make -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling aom"
    set -e
    cd ${SRC_BASE_DIR}
    git clone --depth 1 -b v3.7.0 https://aomedia.googlesource.com/aom
    mkdir -p aom_build
    cd aom_build
    PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        -DENABLE_SHARED=off -DENABLE_NASM=on \
        -DENABLE_TESTS=0 \
        -DENABLE_DOCS=0 \
        -DENABLE_CCACHE=1 \
        ../aom
    PATH="$HOME/bin:$PATH" make  -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling xvid"
    set -e
    cd ${SRC_BASE_DIR}
    wget https://downloads.xvid.com/downloads/xvidcore-${XVID_VERSION}.tar.gz
    tar -xzf xvidcore-${XVID_VERSION}.tar.gz
    cd xvidcore/build/generic
    ./configure --bindir="${PREFIX}/bin" --datadir="${PREFIX}" --enable-shared --enable-shared
    make -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling freetype"
    set -e
    mkdir -p cd ${SRC_BASE_DIR}/freetype
    cd ${SRC_BASE_DIR}/freetype
    curl -sLO https://download.savannah.gnu.org/releases/freetype/freetype-${FREETYPE_VERSION}.tar.gz
    tar -zx --strip-components=1 -f freetype-${FREETYPE_VERSION}.tar.gz
    ./configure --disable-static --enable-shared
    make
    make install
EOT

RUN <<EOT
    echo "Compiling vid.stab"
    set -e
    mkdir -p ${SRC_BASE_DIR}/vid.stab
    cd ${SRC_BASE_DIR}/vid.stab
    curl -sLO https://github.com/georgmartius/vid.stab/archive/v${LIBVIDSTAB_VERSION}.tar.gz
    tar -zx --strip-components=1 -f v${LIBVIDSTAB_VERSION}.tar.gz
    cmake .
    make
    make install
EOT

RUN <<EOT
    echo "Compiling fribidi"
    set -e
    mkdir -p ${SRC_BASE_DIR}/fribidi
    cd ${SRC_BASE_DIR}/fribidi
    curl -sLO https://github.com/fribidi/fribidi/archive/${FRIBIDI_VERSION}.tar.gz
    tar -zx --strip-components=1 -f ${FRIBIDI_VERSION}.tar.gz
    sed -i 's/^SUBDIRS =.*/SUBDIRS=gen.tab charset lib/' Makefile.am
    ./bootstrap --no-config
    ./configure   --disable-static --enable-shared
    make -j 1
    make install
EOT

RUN <<EOT
    echo "Compiling fontconfig"
    set -e
    mkdir -p ${SRC_BASE_DIR}/fontconfig
    cd ${SRC_BASE_DIR}/fontconfig
    curl -sLO https://www.freedesktop.org/software/fontconfig/release/fontconfig-${FONTCONFIG_VERSION}.tar.gz
    tar -xz --strip-components=1 -f fontconfig-${FONTCONFIG_VERSION}.tar.gz
    ./configure   --disable-static --enable-shared
    make
    make install
EOT

RUN <<EOT
    echo "Compiling libass"
    set -e
    mkdir -p ${SRC_BASE_DIR}/libass
    cd ${SRC_BASE_DIR}/libass
    curl -sLO https://github.com/libass/libass/archive/${LIBASS_VERSION}.tar.gz
    tar -zx --strip-components=1 -f ${LIBASS_VERSION}.tar.gz
    ./autogen.sh
    ./configure   --disable-static --enable-shared
    make
    make install
EOT

RUN <<EOT
    echo "Compiling kvazar"
    set -e
    mkdir -p ${SRC_BASE_DIR}/kvazaar
    cd ${SRC_BASE_DIR}/kvazaar
    curl -sLO https://github.com/ultravideo/kvazaar/archive/v${KVAZAAR_VERSION}.tar.gz
    tar -zx --strip-components=1 -f v${KVAZAAR_VERSION}.tar.gz
    ./autogen.sh
    ./configure   --disable-static --enable-shared
    make
    make install
EOT

RUN <<EOT
    echo "Compiling AV1"
    set -e
    cd ${SRC_BASE_DIR}
    git clone --depth 1 https://gitlab.com/AOMediaCodec/SVT-AV1.git
    mkdir -p SVT-AV1/build
    cd SVT-AV1/build
    PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="${PREFIX}" -DCMAKE_BUILD_TYPE=Release -DBUILD_DEC=OFF -DBUILD_SHARED_LIBS=OFF ..
    PATH="$HOME/bin:$PATH" make
    make install
EOT

RUN <<EOT
    echo "Compiling dav1d"
    set -e
    cd ${SRC_BASE_DIR}
    git clone --depth 1 https://code.videolan.org/videolan/dav1d.git
    mkdir -p dav1d/build
    cd dav1d/build
    ~/.local/bin/meson setup -Denable_tools=false -Denable_tests=false --default-library=static .. --prefix "${PREFIX}"  --libdir="${PREFIX}/lib"
    ninja
    ninja install
EOT

RUN <<EOT
    echo "Compiling vmaf"
    set -e
    libvmafver='2.3.1'
    cd ${SRC_BASE_DIR}
    git clone --depth 1 --branch v${libvmafver} https://github.com/Netflix/vmaf.git vmaf-${libvmafver}
    mkdir -p vmaf-${libvmafver}/libvmaf/build /usr/local/share/model/
    cd ${SRC_BASE_DIR}/vmaf-${libvmafver}/libvmaf
    ~/.local/bin/meson build -Denable_tests=false -Denable_docs=false --buildtype=release --default-library=static --prefix "${PREFIX}"  --bindir="/usr/local/bin" --libdir="${PREFIX}/lib"
    cp -r ${SRC_BASE_DIR}/vmaf-${libvmafver}/model/* /usr/local/share/model/
    ninja -vC build
    ninja -vC build install
EOT

RUN <<EOT
    echo "Compiling srt"
    set -e
    cd ${SRC_BASE_DIR}
    git clone --depth 1 --branch v${LIBSRT_VERSION} https://github.com/Haivision/srt.git srt
    cd ${SRC_BASE_DIR}/srt
    cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" .
    make
    make install
EOT

RUN <<EOT
    echo "Compiling libzmq"
    set -e
    cd ${SRC_BASE_DIR}
    git clone --depth 1 --branch v${LIBZMQ_VERSION} https://github.com/zeromq/libzmq.git libzmq
    cd ${SRC_BASE_DIR}/libzmq
    ./autogen.sh
    ./configure --prefix="${PREFIX}"
    make
    make install
EOT

RUN <<EOT
    echo "Compiling libxml"
    set -e
    cd ${SRC_BASE_DIR}
    git clone --depth 1 --branch v${LIBXML2_VERSION} https://github.com/GNOME/libxml2.git libxml2
    cd ${SRC_BASE_DIR}/libxml2
    ./autogen.sh --prefix="${PREFIX}" --with-ftp=no --with-http=no --with-python=no
    make
    make install
EOT

RUN <<EOT
    echo "Compiling libbluray"
    set -e
    mkdir -p ${SRC_BASE_DIR}/libbluray
    cd ${SRC_BASE_DIR}/libbluray
    curl -sLO https://download.videolan.org/pub/videolan/libbluray/${LIBBLURAY_VERSION}/libbluray-${LIBBLURAY_VERSION}.tar.bz2
    tar -jx --strip-components=1 -f libbluray-${LIBBLURAY_VERSION}.tar.bz2
    ./configure --prefix="${PREFIX}" --disable-examples --disable-bdjava-jar --disable-static --enable-shared
    make
    make install
EOT

COPY version.sh /version.sh
RUN <<EOT
    echo "Clonning ffmpeg"
    set -e
    cd ${SRC_BASE_DIR}
    git clone --depth 1 --branch release/6.0 https://git.ffmpeg.org/ffmpeg.git ffmpeg
    chmod +x /version.sh
    mv /version.sh ffmpeg/ffbuild/version.sh
EOT

RUN <<EOT
    echo "Compiling ffmpeg"
    set -e
    cd ${SRC_BASE_DIR}/ffmpeg
    PATH="/usr/bin:$PATH" PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig" ./configure \
        --prefix="${PREFIX}" \
        --pkg-config-flags="--static" \
        --extra-cflags="-I${PREFIX}/include" \
        --extra-ldflags="-L${PREFIX}/lib" \
        --extra-libs="-lpthread -lm -ldl" \
        --bindir="/usr/local/bin" \
        --disable-doc \
        --disable-ffplay \
        --enable-gpl \
        --enable-libopenjpeg \
        --enable-libaom \
        --enable-libass \
        --enable-libfdk-aac \
        --enable-libfreetype \
        --enable-libmp3lame \
        --enable-libopus \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libx264 \
        --enable-nonfree \
        --enable-libxcb \
        --enable-libpulse \
        --enable-alsa \
        --enable-filter=movie \
        --enable-filter=drawtext \
        --enable-libfreetype \
        --enable-filter=overlay \
        --enable-filter=yadif \
        --enable-libopencore-amrnb \
        --enable-libopencore-amrwb \
        --enable-libass \
        --enable-libvidstab \
        --enable-libwebp \
        --enable-libxvid \
        --enable-openssl \
        --enable-libkvazaar \
        --ld="g++" \
        --enable-libvmaf \
        --enable-libx265 \
        --enable-postproc \
        --enable-small \
        --enable-version3 \
        --enable-libsvtav1 \
        --enable-libdav1d \
        --enable-libsrt \
        --enable-libzmq \
        --enable-libbluray \
        --build-suffix=$(cat RELEASE) \
        --extra-version=$(cat RELEASE)
    PATH="/usr/local/bin:$PATH" make -j$(nproc)
    make install
EOT

RUN <<EOT
    echo "Compiling ffmpeg tools"
    set -e
    find / -name ffmpeg
    hash -r
    cd ${SRC_BASE_DIR}/ffmpeg/tools
    make qt-faststart
    cp qt-faststart ${PREFIX}/bin
EOT

RUN <<EOT
    echo "get ffmpeg libs"
    set -e
    LD_LIBRARY_PATH=/usr/local/lib ldd /usr/local/bin/ffmpeg | \
      grep -v '/usr/local/lib' | \
      cut -d ' ' -f 3  | grep -v 'not' | egrep -v "^$" | \
      xargs -i cp -rfvL {} /usr/local/lib/
    cp -rf ${PREFIX}/* /usr/local/
    LD_LIBRARY_PATH=/usr/local/lib ffmpeg -buildconf
    strip /usr/local/lib/*.a
EOT

FROM base AS release
LABEL maintainer="Dmytro Burianov <dmytro@burianov.net>"

COPY --from=build /usr/local /usr/local/

RUN ldconfig /usr/local/lib

ENV LD_LIBRARY_PATH=/usr/local/lib

RUN ffmpeg --help

CMD         ["--help"]
ENTRYPOINT  ["ffmpeg"]

