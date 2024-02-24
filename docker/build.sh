#!/usr/bin/env bash

VERSION="1.3.3"
case "$1" in
    "admin"|"node")
        RUN_TYPE=${1}
        ;;
    *)
        echo "unknown type: ${1}"
        exit
        ;;
esac

docker buildx create --use --platform=linux/arm64,linux/amd64 --name multi-platform-builder
docker buildx inspect --bootstrap

docker buildx build -f Dockerfile.${RUN_TYPE} -t icodex/edge-${RUN_TYPE}:${VERSION} --build-arg VERSION=${VERSION} --platform=linux/arm64,linux/amd64 . --push
