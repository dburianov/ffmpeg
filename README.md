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
## Formats (muxers and demuxers):
### List all formats:
```
ffmpeg -formats
```
### Display options specific to, and information about, a particular muxer:
```
ffmpeg -h muxer=matroska
```
### Display options specific to, and information about, a particular demuxer:
```
ffmpeg -h demuxer=gif
```
## Codecs (encoders and decoders):
### List all codecs:
```
ffmpeg -codecs
```
### List all encoders:
```
ffmpeg -encoders
```
### List all decoders:
```
ffmpeg -decoders
```
### Display options specific to, and information about, a particular encoder:
```
ffmpeg -h encoder=mpeg4
```
### Display options specific to, and information about, a particular decoder:
```
ffmpeg -h decoder=aac
```
### Reading the results
There is a key near the top of the output that describes each letter that precedes the name of the format, encoder, decoder, or codec:
```
$ ffmpeg -encoders
[…]
Encoders:
 V..... = Video
 A..... = Audio
 S..... = Subtitle
 .F.... = Frame-level multithreading
 ..S... = Slice-level multithreading
 ...X.. = Codec is experimental
 ....B. = Supports draw_horiz_band
 .....D = Supports direct rendering method 1
 ------
[…]
 V.S... mpeg4                MPEG-4 part 2
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
### Codecs:
```
 D..... = Decoding supported
 .E.... = Encoding supported
 ..V... = Video codec
 ..A... = Audio codec
 ..S... = Subtitle codec
 ..D... = Data codec
 ..T... = Attachment codec
 ...I.. = Intra frame-only codec
 ....L. = Lossy compression
 .....S = Lossless compression
 -------
 D.VI.S 012v
 D.V.L. 4xm
 D.VI.S 8bps
 .EVIL. a64_multi             (encoders: a64multi )
 .EVIL. a64_multi5            (encoders: a64multi5 )
 D.V..S aasc
 D.V.L. agm
 D.VIL. aic
 DEVI.S alias_pix
 DEVIL. amv
 D.V.L. anm
 D.V.L. ansi
 DEV..S apng
 D.V.L. arbc
 D.V.L. argo
 DEVIL. asv1
 DEVIL. asv2
 D.VIL. aura
 D.VIL. aura2
 DEV.L. av1                   (decoders: libdav1d libaom-av1 av1 ) (encoders: libaom-av1 libsvtav1 )
 D.V... avrn
 DEVI.S avrp
 D.V.L. avs
 ..V.L. avs2
 ..V.L. avs3
 DEVI.S avui
 DEVI.S ayuv
 D.V.L. bethsoftvid
 D.V.L. bfi
 D.V.L. binkvideo
 D.VI.. bintext
 DEVI.S bitpacked
 DEVI.S bmp
 D.V..S bmv_video
 D.VI.S brender_pix
 D.V.L. c93
 D.V.L. cavs
 D.V.L. cdgraphics
 D.V..S cdtoons
 D.VIL. cdxl
 DEV.L. cfhd
 DEV.L. cinepak
 D.V.L. clearvideo
 DEVIL. cljr
 D.VI.S cllc
 D.V.L. cmv                   (decoders: eacmv )
 D.V... cpia
 D.VILS cri
 D.V..S cscd                  (decoders: camstudio )
 D.VIL. cyuv
 ..V.LS daala
 D.VILS dds
 D.V.L. dfa
 DEV.LS dirac                 (encoders: vc2 )
 DEVIL. dnxhd
 DEVI.S dpx
 D.V.L. dsicinvideo
 DEVIL. dvvideo
 D.V..S dxa
 D.VI.S dxtory
 D.VIL. dxv
 D.V.L. escape124
 D.V.L. escape130
 DEVILS exr
 DEV..S ffv1
 DEVI.S ffvhuff
 D.V.L. fic
 DEVI.S fits
 DEV..S flashsv
 DEV.L. flashsv2
 D.V..S flic
 DEV.L. flv1                  (decoders: flv ) (encoders: flv )
 D.V..S fmvc
 D.VI.S fraps
 D.VI.S frwu
 D.V.L. g2m
 D.V.L. gdv
 D.V.L. gem
 DEV..S gif
 DEV.L. h261
 DEV.L. h263                  (decoders: h263 h263_v4l2m2m ) (encoders: h263 h263_v4l2m2m )
 D.V.L. h263i
 DEV.L. h263p
 DEV.LS h264                  (decoders: h264 h264_v4l2m2m ) (encoders: libx264 libx264rgb h264_v4l2m2m h264_vaapi )
 D.VIL. hap
 DEVIL. hdr
 DEV.L. hevc                  (decoders: hevc hevc_v4l2m2m ) (encoders: libx265 hevc_v4l2m2m hevc_vaapi libkvazaar )
 D.V.L. hnm4video
 D.VIL. hq_hqa
 D.VIL. hqx
 DEVI.S huffyuv
 D.VI.S hymt
 D.V.L. idcin                 (decoders: idcinvideo )
 D.VI.. idf
 D.V.L. iff_ilbm              (decoders: iff )
 D.V.L. imm4
 D.V.L. imm5
 D.V.L. indeo2
 D.V.L. indeo3
 D.V.L. indeo4
 D.V.L. indeo5
 D.V.L. interplayvideo
 D.VIL. ipu
 DEVILS jpeg2000              (decoders: jpeg2000 libopenjpeg ) (encoders: jpeg2000 libopenjpeg )
 DEVILS jpegls
 ..VILS jpegxl
 D.VIL. jv
 D.V.L. kgv1
 D.V.L. kmvc
 D.VI.S lagarith
 .EVI.S ljpeg
 D.VI.S loco
 D.V.L. lscr
 D.VI.S m101
 D.V.L. mad                   (decoders: eamad )
 DEVI.S magicyuv
 D.VIL. mdec
 D.VIL. media100
 D.V.L. mimic
 DEVIL. mjpeg                 (encoders: mjpeg mjpeg_vaapi )
 D.VIL. mjpegb
 D.V.L. mmvideo
 D.V.L. mobiclip
 D.V.L. motionpixels
 DEV.L. mpeg1video            (decoders: mpeg1video mpeg1_v4l2m2m )
 DEV.L. mpeg2video            (decoders: mpeg2video mpegvideo mpeg2_v4l2m2m ) (encoders: mpeg2video mpeg2_vaapi )
 DEV.L. mpeg4                 (decoders: mpeg4 mpeg4_v4l2m2m ) (encoders: mpeg4 libxvid mpeg4_v4l2m2m )
 D.V.L. msa1
 D.VI.S mscc
 D.V.L. msmpeg4v1
 DEV.L. msmpeg4v2
 DEV.L. msmpeg4v3             (decoders: msmpeg4 ) (encoders: msmpeg4 )
 D.VI.S msp2
 D.V..S msrle
 D.V.L. mss1
 D.VIL. mss2
 DEV.L. msvideo1
 D.VI.S mszh
 D.V.L. mts2
 D.V.L. mv30
 D.VIL. mvc1
 D.VIL. mvc2
 D.V.L. mvdv
 D.VIL. mvha
 D.V..S mwsc
 D.V.L. mxpeg
 D.VIL. notchlc
 D.V.L. nuv
 D.V.L. paf_video
 DEVI.S pam
 DEVI.S pbm
 DEVI.S pcx
 DEVI.S pfm
 DEVI.S pgm
 DEVI.S pgmyuv
 D.VI.S pgx
 DEVI.S phm
 D.V.L. photocd
 D.VIL. pictor
 D.VIL. pixlet
 DEV..S png
 DEVI.S ppm
 DEVIL. prores                (encoders: prores prores_aw prores_ks )
 D.VIL. prosumer
 D.VI.S psd
 D.VIL. ptx
 D.VI.S qdraw
 DEVI.S qoi
 D.V.L. qpeg
 DEV..S qtrle
 DEVI.S r10k
 DEVI.S r210
 D.V.L. rasc
 DEVI.S rawvideo
 D.VIL. rl2
 DEV.L. roq                   (decoders: roqvideo ) (encoders: roqvideo )
 DEV.L. rpza
 D.V..S rscc
 DEV.L. rv10
 DEV.L. rv20
 D.V.L. rv30
 D.V.L. rv40
 D.V.L. sanm
 D.V.LS scpr
 D.V..S screenpresso
 D.V.L. sga
 DEVI.S sgi
 D.VI.S sgirle
 D.VI.S sheervideo
 D.V.L. simbiosis_imx
 D.V.L. smackvideo            (decoders: smackvid )
 DEV.L. smc
 D.VIL. smvjpeg
 DEV.LS snow
 D.VIL. sp5x
 DEVIL. speedhq
 D.VI.S srgc
 DEVI.S sunrast
 ..V..S svg
 DEV.L. svq1
 D.V.L. svq3
 DEVI.S targa
 D.VI.S targa_y216
 D.V.L. tdsc
 D.V.L. tgq                   (decoders: eatgq )
 D.V.L. tgv                   (decoders: eatgv )
 D.V.L. theora
 D.VIL. thp
 D.V.L. tiertexseqvideo
 DEVI.S tiff
 D.VIL. tmv
 D.V.L. tqi                   (decoders: eatqi )
 D.V.L. truemotion1
 D.V.L. truemotion2
 D.VIL. truemotion2rt
 D.V..S tscc                  (decoders: camtasia )
 D.V.L. tscc2
 D.VIL. txd
 D.V.L. ulti                  (decoders: ultimotion )
 DEVI.S utvideo
 DEVI.S v210
 D.VI.S v210x
 DEVI.S v308
 DEVI.S v408
 DEVI.S v410
 D.V.L. vb
 D.VI.S vble
 DEV.L. vbn
 D.V.L. vc1                   (decoders: vc1 vc1_v4l2m2m )
 D.V.L. vc1image
 D.VIL. vcr1
 D.VIL. vixl                  (decoders: xl )
 D.V.L. vmdvideo
 D.V..S vmnc
 DEV... vnull
 D.V.L. vp3
 D.V.L. vp4
 D.V.L. vp5
 D.V.L. vp6
 D.V.L. vp6a
 D.V.L. vp6f
 D.V.L. vp7
 DEV.L. vp8                   (decoders: vp8 vp8_v4l2m2m libvpx ) (encoders: libvpx vp8_v4l2m2m vp8_vaapi )
 DEV.L. vp9                   (decoders: vp9 vp9_v4l2m2m libvpx-vp9 ) (encoders: libvpx-vp9 vp9_vaapi )
 D.V.L. vqc
 ..V.L. vvc
 DEVI.S wbmp
 D.V..S wcmv
 DEVILS webp                  (encoders: libwebp_anim libwebp )
 DEV.L. wmv1
 DEV.L. wmv2
 D.V.L. wmv3
 D.V.L. wmv3image
 D.VIL. wnv1
 DEV..S wrapped_avframe
 D.V.L. ws_vqa                (decoders: vqavideo )
 D.V.L. xan_wc3
 D.V.L. xan_wc4
 D.VI.. xbin
 DEVI.S xbm
 DEVIL. xface
 D.VI.S xpm
 DEVI.S xwd
 DEVI.S y41p
 D.VI.S ylc
 D.V.L. yop
 DEVI.S yuv4
 D.V..S zerocodec
 DEVI.S zlib
 DEV..S zmbv
 ..AIL. 4gv
 D.AIL. 8svx_exp
 D.AIL. 8svx_fib
 DEAIL. aac                   (decoders: aac aac_fixed libfdk_aac ) (encoders: aac libfdk_aac )
 D.AIL. aac_latm
 DEAIL. ac3                   (decoders: ac3 ac3_fixed ) (encoders: ac3 ac3_fixed )
 D.AIL. acelp.kelvin
 D.AIL. adpcm_4xm
 DEAIL. adpcm_adx
 D.AIL. adpcm_afc
 D.AIL. adpcm_agm
 D.AIL. adpcm_aica
 DEAIL. adpcm_argo
 D.AIL. adpcm_ct
 D.AIL. adpcm_dtk
 D.AIL. adpcm_ea
 D.AIL. adpcm_ea_maxis_xa
 D.AIL. adpcm_ea_r1
 D.AIL. adpcm_ea_r2
 D.AIL. adpcm_ea_r3
 D.AIL. adpcm_ea_xas
 DEAIL. adpcm_g722            (decoders: g722 ) (encoders: g722 )
 DEAIL. adpcm_g726            (decoders: g726 ) (encoders: g726 )
 DEAIL. adpcm_g726le          (decoders: g726le ) (encoders: g726le )
 D.AIL. adpcm_ima_acorn
 DEAIL. adpcm_ima_alp
 DEAIL. adpcm_ima_amv
 D.AIL. adpcm_ima_apc
 DEAIL. adpcm_ima_apm
 D.AIL. adpcm_ima_cunning
 D.AIL. adpcm_ima_dat4
 D.AIL. adpcm_ima_dk3
 D.AIL. adpcm_ima_dk4
 D.AIL. adpcm_ima_ea_eacs
 D.AIL. adpcm_ima_ea_sead
 D.AIL. adpcm_ima_iss
 D.AIL. adpcm_ima_moflex
 D.AIL. adpcm_ima_mtf
 D.AIL. adpcm_ima_oki
 DEAIL. adpcm_ima_qt
 D.AIL. adpcm_ima_rad
 D.AIL. adpcm_ima_smjpeg
 DEAIL. adpcm_ima_ssi
 DEAIL. adpcm_ima_wav
 DEAIL. adpcm_ima_ws
 DEAIL. adpcm_ms
 D.AIL. adpcm_mtaf
 D.AIL. adpcm_psx
 D.AIL. adpcm_sbpro_2
 D.AIL. adpcm_sbpro_3
 D.AIL. adpcm_sbpro_4
 DEAIL. adpcm_swf
 D.AIL. adpcm_thp
 D.AIL. adpcm_thp_le
 D.AIL. adpcm_vima
 D.AIL. adpcm_xa
 D.AIL. adpcm_xmd
 DEAIL. adpcm_yamaha
 D.AIL. adpcm_zork
 DEAI.S alac
 DEAIL. amr_nb                (decoders: amrnb libopencore_amrnb ) (encoders: libopencore_amrnb )
 D.AIL. amr_wb                (decoders: amrwb libopencore_amrwb )
 DEA... anull
 D.AI.S apac
 D.AI.S ape
 DEAIL. aptx
 DEAIL. aptx_hd
 D.AIL. atrac1
 D.AIL. atrac3
 D.AI.S atrac3al
 D.AIL. atrac3p               (decoders: atrac3plus )
 D.AI.S atrac3pal             (decoders: atrac3plusal )
 D.AIL. atrac9
 D.AIL. avc                   (decoders: on2avc )
 D.AIL. binkaudio_dct
 D.AIL. binkaudio_rdft
 D.AIL. bmv_audio
 D.AILS bonk
 D.AIL. cbd2_dpcm
 ..AIL. celt
 ..AIL. codec2
 DEAIL. comfortnoise
 D.AIL. cook
 D.AIL. derf_dpcm
 DEA.L. dfpwm
 D.AIL. dolby_e
 D.AIL. dsd_lsbf
 D.AIL. dsd_lsbf_planar
 D.AIL. dsd_msbf
 D.AIL. dsd_msbf_planar
 D.AIL. dsicinaudio
 D.AIL. dss_sp
 D.AI.S dst
 DEAILS dts                   (decoders: dca ) (encoders: dca )
 D.AIL. dvaudio
 DEAIL. eac3
 D.AIL. evrc
 D.AIL. fastaudio
 DEAI.S flac
 D.AIL. ftr
 DEAIL. g723_1
 D.AIL. g729
 D.AIL. gremlin_dpcm
 D.AIL. gsm
 D.AIL. gsm_ms
 D.AIL. hca
 D.AIL. hcom
 D.AIL. iac
 D.AIL. ilbc
 D.AIL. imc
 D.AIL. interplay_dpcm
 D.AIL. interplayacm
 D.AIL. mace3
 D.AIL. mace6
 D.AIL. metasound
 D.AIL. misc4
 DEA..S mlp
 D.AIL. mp1                   (decoders: mp1 mp1float )
 DEAIL. mp2                   (decoders: mp2 mp2float ) (encoders: mp2 mp2fixed )
 DEAIL. mp3                   (decoders: mp3float mp3 ) (encoders: libmp3lame )
 D.AIL. mp3adu                (decoders: mp3adufloat mp3adu )
 D.AIL. mp3on4                (decoders: mp3on4float mp3on4 )
 D.AI.S mp4als                (decoders: als )
 ..A.L. mpegh_3d_audio
 D.AIL. msnsiren
 D.AIL. musepack7             (decoders: mpc7 )
 D.AIL. musepack8             (decoders: mpc8 )
 DEAIL. nellymoser
 DEAIL. opus                  (decoders: opus libopus ) (encoders: opus libopus )
 D.AIL. paf_audio
 DEAIL. pcm_alaw
 DEAI.S pcm_bluray
 DEAI.S pcm_dvd
 D.AI.S pcm_f16le
 D.AI.S pcm_f24le
 DEAI.S pcm_f32be
 DEAI.S pcm_f32le
 DEAI.S pcm_f64be
 DEAI.S pcm_f64le
 D.AI.S pcm_lxf
 DEAIL. pcm_mulaw
 DEAI.S pcm_s16be
 DEAI.S pcm_s16be_planar
 DEAI.S pcm_s16le
 DEAI.S pcm_s16le_planar
 DEAI.S pcm_s24be
 DEAI.S pcm_s24daud
 DEAI.S pcm_s24le
 DEAI.S pcm_s24le_planar
 DEAI.S pcm_s32be
 DEAI.S pcm_s32le
 DEAI.S pcm_s32le_planar
 DEAI.S pcm_s64be
 DEAI.S pcm_s64le
 DEAI.S pcm_s8
 DEAI.S pcm_s8_planar
 D.AI.S pcm_sga
 DEAI.S pcm_u16be
 DEAI.S pcm_u16le
 DEAI.S pcm_u24be
 DEAI.S pcm_u24le
 DEAI.S pcm_u32be
 DEAI.S pcm_u32le
 DEAI.S pcm_u8
 DEAIL. pcm_vidc
 D.AIL. qcelp
 D.AIL. qdm2
 D.AIL. qdmc
 DEAIL. ra_144                (decoders: real_144 ) (encoders: real_144 )
 D.AIL. ra_288                (decoders: real_288 )
 D.AI.S ralf
 D.AILS rka
 DEAIL. roq_dpcm
 DEAI.S s302m
 DEAIL. sbc
 D.AIL. sdx2_dpcm
 D.AI.S shorten
 D.AIL. sipr
 D.AIL. siren
 D.AIL. smackaudio            (decoders: smackaud )
 ..AIL. smv
 D.AIL. sol_dpcm
 DEAI.. sonic
 .EAI.. sonicls
 D.AIL. speex
 D.A..S tak
 DEA..S truehd
 D.AIL. truespeech
 DEAI.S tta
 D.AIL. twinvq
 D.AIL. vmdaudio
 DEAIL. vorbis                (decoders: vorbis libvorbis ) (encoders: vorbis libvorbis )
 D.AIL. wady_dpcm
 D.AI.S wavarc
 D.AI.. wavesynth
 DEAILS wavpack
 D.AIL. westwood_snd1         (decoders: ws_snd1 )
 D.AI.S wmalossless
 D.AIL. wmapro
 DEAIL. wmav1
 DEAIL. wmav2
 D.AIL. wmavoice
 D.AIL. xan_dpcm
 D.AIL. xma1
 D.AIL. xma2
 ..D... bin_data
 ..D... dvd_nav_packet
 ..D... epg
 ..D... klv
 ..D... mpegts
 ..D... otf
 ..D... scte_35
 ..D... timed_id3
 ..D... ttf
 ..S... arib_caption
 DES... ass                   (decoders: ssa ass ) (encoders: ssa ass )
 DES... dvb_subtitle          (decoders: dvbsub ) (encoders: dvbsub )
 ..S... dvb_teletext
 DES... dvd_subtitle          (decoders: dvdsub ) (encoders: dvdsub )
 D.S... eia_608               (decoders: cc_dec )
 D.S... hdmv_pgs_subtitle     (decoders: pgssub )
 ..S... hdmv_text_subtitle
 D.S... jacosub
 D.S... microdvd
 DES... mov_text
 D.S... mpl2
 D.S... pjs
 D.S... realtext
 D.S... sami
 ..S... srt
 ..S... ssa
 D.S... stl
 DES... subrip                (decoders: srt subrip ) (encoders: srt subrip )
 D.S... subviewer
 D.S... subviewer1
 DES... text
 .ES... ttml
 D.S... vplayer
 DES... webvtt
 DES... xsub
```
### File formats:
```

 D. = Demuxing supported
 .E = Muxing supported
 --
 D  3dostr
  E 3g2
  E 3gp
 D  4xm
  E a64
 D  aa
 D  aac
 D  aax
 DE ac3
 D  ace
 D  acm
 D  act             ACT Voice file format
 D  adf
 D  adp
 D  ads
  E adts
 DE adx
 D  aea
 D  afc
 DE aiff
 D  aix
 DE alaw
 D  alias_pix
 DE alp
 DE alsa
 DE amr
 D  amrnb
 D  amrwb
  E amv
 D  anm
 D  apac
 D  apc
 D  ape
 DE apm
 DE apng
 DE aptx
 DE aptx_hd
 D  aqtitle
 DE argo_asf
 D  argo_brp
 DE argo_cvg
 DE asf
 D  asf_o
  E asf_stream
 DE ass
 DE ast
 DE au
 D  av1
 DE avi
  E avif
  E avm2
 D  avr
 D  avs
 DE avs2
 DE avs3
 D  bethsoftvid
 D  bfi
 D  bfstm
 D  bin
 D  bink
 D  binka
 DE bit
 D  bitpacked
 D  bmp_pipe
 D  bmv
 D  boa
 D  bonk
 D  brender_pix
 D  brstm
 D  c93
 DE caf
 DE cavsvideo
 D  cdg
 D  cdxl
 D  cine
 DE codec2
 DE codec2raw
 D  concat
  E crc
 D  cri_pipe
  E dash
 DE data
 DE daud
 D  dcstr
 D  dds_pipe
 D  derf
 D  dfa
 DE dfpwm
 D  dhav
 DE dirac
 DE dnxhd
 D  dpx_pipe
 D  dsf
 D  dsicin
 D  dss
 DE dts
 D  dtshd
 DE dv
 D  dvbsub
 D  dvbtxt
  E dvd
 D  dxa
 D  ea
 D  ea_cdata
 DE eac3
 D  epaf
 D  exr_pipe
 DE f32be
 DE f32le
  E f4v
 DE f64be
 DE f64le
 DE fbdev
 DE ffmetadata
  E fifo
  E fifo_test
 DE film_cpk
 DE filmstrip
 DE fits
 DE flac
 D  flic
 DE flv
  E framecrc
  E framehash
  E framemd5
 D  frm
 D  fsb
 D  fwse
 DE g722
 DE g723_1
 DE g726
 DE g726le
 D  g729
 D  gdv
 D  gem_pipe
 D  genh
 DE gif
 D  gif_pipe
 DE gsm
 DE gxf
 DE h261
 DE h263
 DE h264
  E hash
 D  hca
 D  hcom
 D  hdr_pipe
  E hds
 DE hevc
 DE hls
 D  hnm
 DE ico
 D  idcin
 D  idf
 D  iff
 D  ifv
 DE ilbc
 DE image2
 DE image2pipe
 D  ingenient
 D  ipmovie
  E ipod
 D  ipu
 DE ircam
  E ismv
 D  iss
 D  iv8
 DE ivf
 D  ivr
 D  j2k_pipe
 DE jacosub
 D  jpeg_pipe
 D  jpegls_pipe
 D  jpegxl_pipe
 D  jv
 D  kux
 DE kvag
 D  laf
  E latm
 D  lavfi
 D  live_flv
 D  lmlm4
 D  loas
 DE lrc
 D  luodat
 D  lvf
 D  lxf
 DE m4v
  E matroska
 D  matroska,webm
 D  mca
 D  mcc
  E md5
 D  mgsts
 DE microdvd
 DE mjpeg
 D  mjpeg_2000
  E mkvtimestamp_v2
 DE mlp
 D  mlv
 D  mm
 DE mmf
 D  mods
 D  moflex
  E mov
 D  mov,mp4,m4a,3gp,3g2,mj2
  E mp2
 DE mp3
  E mp4
 D  mpc
 D  mpc8
 DE mpeg
  E mpeg1video
  E mpeg2video
 DE mpegts
 D  mpegtsraw
 D  mpegvideo
 DE mpjpeg
 D  mpl2
 D  mpsub
 D  msf
 D  msnwctcp
 D  msp
 D  mtaf
 D  mtv
 DE mulaw
 D  musx
 D  mv
 D  mvi
 DE mxf
  E mxf_d10
  E mxf_opatom
 D  mxg
 D  nc
 D  nistsphere
 D  nsp
 D  nsv
  E null
 DE nut
 D  nuv
 DE obu
  E oga
 DE ogg
  E ogv
 DE oma
  E opus
 DE oss
 D  paf
 D  pam_pipe
 D  pbm_pipe
 D  pcx_pipe
 D  pfm_pipe
 D  pgm_pipe
 D  pgmyuv_pipe
 D  pgx_pipe
 D  phm_pipe
 D  photocd_pipe
 D  pictor_pipe
 D  pjs
 D  pmp
 D  png_pipe
 D  pp_bnk
 D  ppm_pipe
 D  psd_pipe
  E psp
 D  psxstr
 DE pulse
 D  pva
 D  pvf
 D  qcp
 D  qdraw_pipe
 D  qoi_pipe
 D  r3d
 DE rawvideo
 D  realtext
 D  redspark
 D  rka
 D  rl2
 DE rm
 DE roq
 D  rpl
 D  rsd
 DE rso
 DE rtp
  E rtp_mpegts
 DE rtsp
 DE s16be
 DE s16le
 DE s24be
 DE s24le
 DE s32be
 DE s32le
 D  s337m
 DE s8
 D  sami
 DE sap
 DE sbc
 D  sbg
 DE scc
 D  scd
  E sdl,sdl2
 D  sdns
 D  sdp
 D  sdr2
 D  sds
 D  sdx
  E segment
 D  ser
 D  sga
 D  sgi_pipe
 D  shn
 D  siff
 D  simbiosis_imx
 D  sln
 DE smjpeg
 D  smk
  E smoothstreaming
 D  smush
 DE sndio
 D  sol
 DE sox
 DE spdif
  E spx
 DE srt
 D  stl
  E stream_segment,ssegment
  E streamhash
 D  subviewer
 D  subviewer1
 D  sunrast_pipe
 DE sup
 D  svag
  E svcd
 D  svg_pipe
 D  svs
 DE swf
 D  tak
 D  tedcaptions
  E tee
 D  thp
 D  tiertexseq
 D  tiff_pipe
 D  tmv
 DE truehd
 DE tta
  E ttml
 D  tty
 D  txd
 D  ty
 DE u16be
 DE u16le
 DE u24be
 DE u24le
 DE u32be
 DE u32le
 DE u8
  E uncodedframecrc
 D  v210
 D  v210x
 D  vag
 D  vbn_pipe
 DE vc1
 DE vc1test
  E vcd
 DE vidc
 DE video4linux2,v4l2
 D  vividas
 D  vivo
 D  vmd
  E vob
 D  vobsub
 DE voc
 D  vpk
 D  vplayer
 D  vqf
 DE w64
 D  wady
 DE wav
 D  wavarc
 D  wc3movie
  E webm
  E webm_chunk
 DE webm_dash_manifest
  E webp
 D  webp_pipe
 DE webvtt
 DE wsaud
 D  wsd
 D  wsvqa
 DE wtv
 DE wv
 D  wve
 D  x11grab
 D  xa
 D  xbin
 D  xbm_pipe
 D  xmd
 D  xmv
 D  xpm_pipe
  E xv
 D  xvag
 D  xwd_pipe
 D  xwma
 D  yop
 DE yuv4mpegpipe
```
