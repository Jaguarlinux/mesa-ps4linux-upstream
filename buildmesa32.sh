#!/bin/sh
cd build && 
rm -rf * && 
meson setup  \
  --buildtype=release  \
  --cross-file=lib32 \
  --prefix=/usr \
  --libdir=/usr/lib32 \
  -Dplatforms=x11,wayland \
  -Dvulkan-drivers=amd,swrast,virtio \
  -Dshader-cache=enabled  \
  -Dshader-cache-max-size=8G \
  -Dvulkan-layers=device-select,overlay,screenshot \
  -Dgallium-extra-hud=true \
  -Dgallium-drivers=radeonsi,r600,zink,virgl,softpipe,llvmpipe \
  -Dopengl=true \
  -Dgles1=enabled \
  -Dgles2=enabled \
  -Degl=enabled \
  -Dllvm=enabled \
  -Dlmsensors=enabled  \
  -Dglx=dri \
  -Dtools=glsl,nir \
  -Dgallium-vdpau=enabled \
  -Dgallium-va=enabled  \
  -Dglvnd=enabled  \
  -Dlibunwind=enabled  \
  -Dosmesa=true \
  -Dgallium-nine=true \
  -Dvideo-codecs=vc1dec,h264dec,h264enc,h265dec,h265enc,av1dec,av1enc,vp9dec \
  -Dlegacy-x11=dri2 \
  -Dteflon=true \
  -Dzstd=enabled \
  -Dshared-glapi=enabled \
  -Dmicrosoft-clc=disabled \
  -Dvalgrind=disabled  \
   .. &&
sed -i 's/\/usr\/lib\//\/usr\/lib32\//g' ./build.ninja &&
BINDGEN_EXTRA_CLANG_ARGS="-m32" ninja -j4
