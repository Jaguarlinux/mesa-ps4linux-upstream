
mkdir -pv build
cd build
meson setup  \
  --buildtype=release \
  -Dprefix=/usr \
  -Dplatforms=x11,wayland \
  -Dvulkan-drivers=amd,swrast,virtio \
  -Dshader-cache=enabled \
  -Dshader-cache-max-size=8G \
  -Dvulkan-layers=device-select,overlay,screenshot \
  -Dgallium-extra-hud=true \
  -Dgallium-drivers=radeonsi,r600,zink,virgl,softpipe,llvmpipe \
  -Dopengl=true \
  -Dgles1=enabled \
  -Dgles2=enabled \
  -Degl=enabled \
  -Dllvm=enabled \
  -Dlmsensors=enabled \
  -Dglx=dri \
  -Dtools=glsl,nir \
  -Dgallium-vdpau=enabled \
  -Dgallium-va=enabled \
  -Dglvnd=enabled \
  -Dlibunwind=enabled \
  -Dosmesa=true \
  -Dgallium-nine=true \
  -Dvideo-codecs=vc1dec,h264dec,h264enc,h265dec,h265enc,av1dec,av1enc,vp9dec \
  -Dlegacy-x11=dri2 \
  -Dteflon=true \
  -Dzstd=enabled \
  -Dshared-glapi=enabled \
  -Dmicrosoft-clc=disabled  \
  -Dvalgrind=disabled  \
  .. &&
meson configure  && \
ninja 
