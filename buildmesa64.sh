#!/bin.sh
mkdir -pv build && \
cd build
meson setup \
  --buildtype=release \
  -Dprefix=/usr \
  -Dplatforms=x11,wayland \
  -Dvulkan-beta=true \
  -Dvulkan-drivers=all \
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
  -Dopengl=true \
  -Dgallium-xa=enabled \
  -Dgallium-rusticl=true \
  -Dgallium-rusticl-enable-drivers=radeonsi \
  -Dimagination-srv=true \
  -Dglx=dri \
  -Dgles1=enabled \
  -Dgles2=enabled \
  -Degl=enabled \
  -Dllvm=enabled \
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
  -Dxlib-lease=true \
  -Dglx-direct=true \
  -Dshader-cache=enabled \
  -Dshader-cache-max-size=8G \
  -Dglvnd=disabled  \
  ..&&

ninja \
meson configure -D build-tests=true && \
ninja test && \
ninja install && \
cp -rv ../docs -T /usr/share/doc/mesa-25.1.5
