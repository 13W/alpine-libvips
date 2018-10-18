FROM debian
# https://github.com/jcupitt/libvips

COPY vips-8.6.5.tar.gz /tmp/vips-8.6.5.tar.gz
WORKDIR /tmp

RUN echo "deb http://deb.debian.org/debian jessie-backports main contrib non-free" >>/etc/apt/sources.list && \
  echo "deb http://deb.debian.org/debian jessie-backports-sloppy main contrib non-free" >>/etc/apt/sources.list && \
  apt update && \
  apt install -y \
    dpkg-dev \
    pkg-config \
    libglib2.0-dev \
    libexif-dev \
    libexpat1-dev \
    libtiff5-dev \
    libjpeg62-turbo-dev \
    libgsf-1-dev \
    libgif-dev \
    libpng-dev \
    librsvg2-dev \
    libavcodec57 \
    libavformat57 \
    libswscale4 \
    libavcodec-dev \
    libavutil-dev \
    libavformat-dev \
    libswscale-dev \
    libwebp-dev \
    imagemagick \
    ca-certificates && \

  tar zvxf vips-8.6.5.tar.gz && \
  cd vips-8.6.5 && \
  ./configure && \
  make -j4 && \
  make install && \
  rm -rf /tmp/vips-* && \

  rm -rf /var/cache/apt/* && \
  rm -rf /tmp/vips-*

ENV CPATH /usr/local/include
ENV LIBRARY_PATH /usr/local/lib
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
ENV LD_LIBRARY_PATH=/usr/local/lib
