# ffmpeg

[![pipeline status](https://gitlab.com/burianov/ffmpeg/badges/main/pipeline.svg)](https://gitlab.com/burianov/ffmpeg/-/commits/main)[![coverage report](https://gitlab.com/burianov/ffmpeg/badges/main/coverage.svg)](https://gitlab.com/burianov/ffmpeg/-/commits/main)[![Latest Release](https://gitlab.com/burianov/ffmpeg/-/badges/release.svg)](https://gitlab.com/burianov/ffmpeg/-/releases)

Linux ARM64 and AMD64 platform both


### Tested on:
```
Linux 3a37615f3c9f 6.2.0-34-generic #34~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Sep  7 13:12:03 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
```
```
Linux 330b39f1c79f 6.1.0-rpi4-rpi-v8 #1 SMP PREEMPT Debian 1:6.1.54-1+rpt2 (2023-10-05) aarch64 aarch64 aarch64 GNU/Linux
```
### Version:
```
ffmpeg version 6.0-c5039e1 Copyright (c) 2000-2023 the FFmpeg developers
  built with gcc 11 (Ubuntu 11.4.0-1ubuntu1~22.04)
```
### Build configuraton
```
  configuration:
    --prefix=/usr/ffmpeg_build
    --pkg-config-flags=--static
    --extra-cflags=-I/usr/ffmpeg_build/include
    --extra-ldflags=-L/usr/ffmpeg_build/lib
    --extra-libs='-lpthread -lm -ldl'
    --bindir=/usr/local/bin
    --disable-doc
    --disable-ffplay
    --enable-gpl
    --enable-libopenjpeg
    --enable-libaom
    --enable-libass
    --enable-libfdk-aac
    --enable-libfreetype
    --enable-libmp3lame
    --enable-libopus
    --enable-libvorbis
    --enable-libvpx
    --enable-libx264
    --enable-nonfree
    --enable-libxcb
    --enable-libpulse
    --enable-alsa
    --enable-filter=movie
    --enable-filter=drawtext
    --enable-libfreetype
    --enable-filter=overlay
    --enable-filter=yadif
    --enable-libopencore-amrnb
    --enable-libopencore-amrwb
    --enable-libass
    --enable-libvidstab
    --enable-libwebp
    --enable-libxvid
    --enable-openssl
    --enable-libkvazaar
    --ld=g++
    --enable-libvmaf
    --enable-libx265
    --enable-postproc
    --enable-small
    --enable-version3
    --enable-libsvtav1
    --enable-libdav1d
    --enable-libsrt
    --enable-libzmq
    --enable-libbluray
    --build-suffix=6.0
    --extra-version=6.0
    libavutil      58.  2.100 / 58.  2.100
    libavcodec     60.  3.100 / 60.  3.100
    libavformat    60.  3.100 / 60.  3.100
    libavdevice    60.  1.100 / 60.  1.100
    libavfilter     9.  3.100 /  9.  3.100
    libswscale      7.  1.100 /  7.  1.100
    libswresample   4. 10.100 /  4. 10.100
    libpostproc    57.  1.100 / 57.  1.100
```
