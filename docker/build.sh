#!/usr/bin/env bash

case "$1" in
    "admin"|"node")
        RUN_TYPE=$1
        ;;
    *)
        echo "USAGE: $0 from to"
        echo " e.g.: $0 admin"
        echo " e.g.: $0 node"
        exit
        ;;
esac

VERSION=$2
LATEST=$3

if [ $# -lt 2 ] ; then
    echo "USAGE: $0 from to"
    echo " e.g.: $0 $1 1.3.3"
    echo " e.g.: $0 $1 1.3.3 latest"
    exit 1;
fi

if [ "$LATEST"x = "latest"x ];then
    IMG_VERSION="latest"
else
    IMG_VERSION=$VERSION
fi

docker buildx create --use --platform=linux/arm64,linux/amd64 --name multi-platform-builder
docker buildx inspect --bootstrap

docker buildx build -f Dockerfile.${RUN_TYPE} -t icodex/edge-${RUN_TYPE}:${IMG_VERSION} --build-arg VERSION=${VERSION} --build-arg RUN_TYPE=${RUN_TYPE} --platform=linux/arm64,linux/amd64 . --push
