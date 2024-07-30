#!/usr/bin/env bash

case "$1" in
    "admin"|"node"|"user"|"dns")
        RUN_TYPE=$1
        ;;
    *)
        echo "USAGE: $0 from to"
        echo " e.g.: $0 admin"
        echo " e.g.: $0 node"
        echo " e.g.: $0 user"
        echo " e.g.: $0 dns"
        exit
        ;;
esac

VERSION=$2
LATEST=$3

if [ $# -lt 2 ] ; then
    echo "USAGE: $0 from to"
    echo " e.g.: $0 $1 1.3.9"
    echo " e.g.: $0 $1 1.3.9 latest"
    exit 1;
fi

if [ "$LATEST"x = "latest"x ];then
    IMG_VERSION="latest"
else
    IMG_VERSION=$VERSION
fi

docker buildx create --use --platform=linux/arm64,linux/amd64 --name multi-platform-builder
docker buildx inspect --bootstrap

docker buildx build -f Dockerfile -t icodex/edge-${RUN_TYPE}:${IMG_VERSION} --build-arg RUN_TYPE=${RUN_TYPE} --build-arg VERSION=${VERSION} --platform=linux/arm64,linux/amd64 . --push
