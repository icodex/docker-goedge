#!/usr/bin/env sh

echo "**** Install based packages ****"
apk add --no-cache tzdata wget curl unzip
cp /usr/share/zoneinfo/${TZ} /etc/localtime
