#!/bin/sh
VERSION=${1:-latest}
docker build --no-cache --force-rm --rm --tag me13w/debian-vips:${VERSION} .
