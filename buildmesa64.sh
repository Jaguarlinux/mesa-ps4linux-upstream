
 mkdir -p build && \
 cd build
  meson setup \
    --buildtype=release \
    -Dprefix=/usr \
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
    -Dglvnd=disabled && \

meson configure && \
ninja -j4  && \
ninja install && \
cp -rv ../docs -T /usr/share/doc/mesa-25.2.0
