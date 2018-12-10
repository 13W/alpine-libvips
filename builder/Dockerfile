FROM digiselfie/debian-vips
RUN apt install -y jq git && \
  wget -q "https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz" -O /tmp/go.tar.gz && \
  (mkdir /go && cd /go && tar --strip-components=1 -xf /tmp/go.tar.gz) && \
  rm -rf /tmp/go.tar.gz && \
  /go/bin/go get -u github.com/go-swagger/go-swagger/cmd/swagger

ENV PATH="/go/bin:${PATH}"
ENV GOROOT=/go
ENV GOPATH=/app

