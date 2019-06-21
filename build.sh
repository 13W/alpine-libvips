#!/bin/sh
export VERSION=${1:-"latest"}
export GO_VERSION=${2:-"1.11.2"}

docker build --no-cache --force-rm --rm --tag me13w/debian-vips:${VERSION} .

docker build --no-cache --force-rm --rm --tag me13w/debian-vips-build:${VERSION} . -f-<<END
FROM me13w/debian-vips:${VERSION}
RUN apt install -y jq git && \
  wget -q "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz" -O /tmp/go.tar.gz && \
  (mkdir /go && cd /go && tar --strip-components=1 -xf /tmp/go.tar.gz) && \
  rm -rf /tmp/go.tar.gz && \
  /go/bin/go get -u github.com/go-swagger/go-swagger/cmd/swagger

ENV PATH="/go/bin:${PATH}"
ENV GOROOT=/go
ENV GOPATH=/app

END
