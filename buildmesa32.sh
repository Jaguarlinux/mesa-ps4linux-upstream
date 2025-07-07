#!/bin.sh
cd build
rm -rfv *
meson setup \
  --cross-file=lib32       \
  --buildtype=release \
  -Dprefix=/usr \
  --libdir=/usr/lib32      \
  -Dplatforms=x11,wayland \
  -Dvulkan-beta=true \
  -Dvulkan-drivers=amd, broadcom, freedreno, intel, intel_hasvk,panfrost,swrast,virtio,imagination-experimental,microsoft-experimental,nouveau,asahi,gfxstream \
  -Dvulkan-layers=device-select,overlay,screenshot \
  -Dbuild-aco-tests=true \
  -Damdgpu-virtio=true \
  -Dgallium-rusticl=true \
  -Dgallium-extra-hud=true \
  -Dgallium-drivers=all \
  -Dgallium-nine=true \
  -Dgallium-vdpau=enabled \
  -Dgallium-va=enabled \
  -Dgallium-extra-hud=true \
  -Degl-native-platform=x11,wayland \
  -Dopengl=true \
  -Dgallium-xa=true \
  -Dgallium-d3d10umd=true \
  -Dgallium-rusticl=true \
  -Dgallium-rusticl-enable-drivers=radeonsi \
  -Dimagination-srv=true \
  -Dglx=dri,xlib \
  -Dgles1=enabled \
  -Dgles2=enabled \
  -Degl=enabled \
  -Dllvm=auto \
  -Dlmsensors=enabled \
  -Dtools=glsl,nir \
  -Dlibunwind=enabled \
  -Dvideo-codecs=all \
  -Dlegacy-x11=dri2 \
  -Dzstd=enabled \
  -Damd-use-llvm=true \
  -Dspirv-to-dxil=true \
  -Dstatic-libclc=all \
  -Dmesa-clc=enabled \
  -Dinstall-mesa-clc=true \
  -Dinstall-precomp-compiler=true \
  -Dosmesa=true \
  -Dprecomp-compiler=enabled \
  -Dmicrosoft-clc=disabled \
  -Dvalgrind=disabled \
  -Dtools=all \
  -Dxlib-lease=true \
  -Dglx-direct=true \
  -Dshader-cache=enabled \
  -Dshader-cache-max-size=8G \
  -Dglvnd=disabled  \
  ..&&
sed -i 's/\/usr\/lib\//\/usr\/lib32\//g' ./build.ninja &&
BINDGEN_EXTRA_CLANG_ARGS="-m32" ninja -j4

DESTDIR=$PWD/DESTDIR ninja install                     &&
cp -vr DESTDIR/usr/lib32/* /usr/lib32                  &&
if [ -d DESTDIR/usr/share/vulkan ]; then
    cp -vR DESTDIR/usr/share/vulkan /usr/share
fi                                                     &&
rm -rf DESTDIR                                         &&
ldconfig
