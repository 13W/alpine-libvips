FROM debian:buster
# https://github.com/jcupitt/libvips

WORKDIR /tmp

RUN echo "deb http://deb.debian.org/debian buster-backports main contrib non-free" >> /etc/apt/sources.list && \
  apt update && \
  apt upgrade -y && \
  apt install -y \
    wget \
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
    libavcodec58 \
    libavformat58 \
    libswscale5 \
    libavcodec-dev \
    libavutil-dev \
    libavformat-dev \
    libswscale-dev \
    libwebp-dev \
    libmagic-dev \
    libde265-dev \
    libx265-dev \
    ca-certificates \
    autoconf \
    libtool \
    swig \
    gobject-introspection \
    gtk-doc-tools && \
  mkdir libheif && cd $_ && \
  wget -O libheif.tar.gz https://github.com/strukturag/libheif/releases/download/v1.3.2/libheif-1.3.2.tar.gz && \
  tar --strip=1 -xvf libheif.tar.gz && \
  ./autogen.sh && \
  ./configure && \
  make -j4 -s && \
  make install && \
  cd .. && \
  mkdir ImageMagic && cd $_ && \
  wget -O ImageMagick.tar.gz https://imagemagick.org/download/ImageMagick.tar.gz && \
  tar --strip=1 -xvf ImageMagick.tar.gz && \
  ./configure && \
  make -j4 -s && \
  make install && \
  cd .. && \
  mkdir vips && cd $_ && \
  wget -O vips.tar.gz https://github.com/jcupitt/libvips/archive/v8.7.0.tar.gz && \
  tar --strip=1 -zvxf vips.tar.gz && \
  ./autogen.sh && \
  ./configure && \
  make -j4 -s && \
  make install && \
  cd .. && \
  rm -rf /tmp/libheif /tmp/vips /tmp/ImageMagic /var/cache/apt/*

ENV CPATH /usr/local/include
ENV LIBRARY_PATH /usr/local/lib
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
ENV LD_LIBRARY_PATH=/usr/local/lib
