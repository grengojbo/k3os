FROM golang:1.13-alpine AS gobuild
RUN apk -U add git gcc linux-headers musl-dev make libseccomp libseccomp-dev bash
COPY images/10-gobuild/gobuild /usr/bin/
RUN rm -f /bin/sh && ln -s /bin/bash /bin/sh
# WORKDIR /output

FROM gobuild as k3os
# ARG VERSION
# COPY /cmd/ $GOPATH/src/github.com/rancher/k3os/cmd/
# COPY /pkg/ $GOPATH/src/github.com/rancher/k3os/pkg/
COPY /main.go $GOPATH/src/github.com/rancher/k3os/
# COPY /vendor/ $GOPATH/src/github.com/rancher/k3os/vendor/
WORKDIR $GOPATH/src/github.com/rancher/k3os
# RUN gobuild -o /output/k3os