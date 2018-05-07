FROM octoblu/alpine-ca-certificates:latest
# https://github.com/jcupitt/libvips

#COPY vips-8.6.3.tar.gz /tmp/vips-8.6.3.tar.gz
WORKDIR /tmp
ENV LIBVIPS_VERSION_MAJOR 8
ENV LIBVIPS_VERSION_MINOR 6
ENV LIBVIPS_VERSION_PATCH 3

RUN apk add --no-cache --virtual .build-deps \
  gcc g++ make libc-dev \
  automake \
  libtool \
  tar \
  gettext \
  ca-certificates \
  openssl \
  curl && \

apk add --no-cache --virtual .libdev-deps \
  glib-dev \
  imagemagick-dev \
  libgsf-dev \
  fftw-dev \
  libpng-dev \
  libwebp-dev \
  libexif-dev \
  libxml2-dev \
  giflib-dev \
  tiff-dev \
  libjpeg-turbo-dev \
  expat-dev && \

apk add --no-cache --virtual .run-deps \
  glib \
  libpng \
  libwebp \
  libexif \
  libxml2 \
  libjpeg-turbo \
  libstdc++ \
  libgcc \
  imagemagick \
  giflib \
  fftw \
  libgsf \
  expat && \

  LIBVIPS_VERSION=${LIBVIPS_VERSION_MAJOR}.${LIBVIPS_VERSION_MINOR}.${LIBVIPS_VERSION_PATCH} && \
  wget https://github.com/jcupitt/libvips/releases/download/v${LIBVIPS_VERSION_MAJOR}.${LIBVIPS_VERSION_MINOR}.${LIBVIPS_VERSION_PATCH}/vips-${LIBVIPS_VERSION}.tar.gz && \
  tar zvxf vips-${LIBVIPS_VERSION}.tar.gz && \
  cd vips-${LIBVIPS_VERSION} && \
  ./configure && \
  make -j4 && \
  make install && \
  rm -rf /tmp/vips-* && \

  apk del .build-deps && \
  apk del .libdev-deps && \
  rm -rf /var/cache/apk/* && \
  rm -rf /tmp/vips-*

ENV CPATH /usr/local/include
ENV LIBRARY_PATH /usr/local/lib
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

