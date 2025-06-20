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
  -Dvulkan-drivers=amd,swrast,virtio \
  -Dvulkan-layers=device-select,overlay,screenshot \
  -Dbuild-aco-tests=true \
  -Dgallium-rusticl=true \
  -Dgallium-extra-hud=true \
  -Dgallium-drivers=radeonsi,r600,zink,virgl,softpipe,llvmpipe \
  -Dgallium-nine=true \
  -Dgallium-vdpau=enabled \
  -Dgallium-va=enabled \
  -Dopengl=true \
  -Dglx=auto \
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
