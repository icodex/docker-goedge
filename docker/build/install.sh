#!/usr/bin/env sh

echo "**** Install goedge ****"

function get_arch() {
	ARCH=`uname -m`
	case "$ARCH" in
		"x86_64")
			GOARCH="amd64"
			;;
		"aarch64_be"|"aarch64"|"armv8b"|"armv8l"|"armv8"|"arm64")
			GOARCH="arm64"
			;;
		*)
			echo "arch '${ARCH}' is not supported yet"
			exit
			;;
	esac
}

function install_edges() {
	mkdir -p ${ROOT_DIR}
	cd ${ROOT_DIR}

	case "$1" in
		"admin")
			TAR_URL="https://static-file-global.353355.xyz/goedge/edge-admin-linux-${GOARCH}-plus-v${VERSION}.zip"
			TAR_FILE="edge-admin-linux-${GOARCH}-plus-v${VERSION}.zip"

			mv /build/run_admin.sh ${ROOT_DIR}/run.sh
			;;
		"node")
			apk add --no-cache nftables
			TAR_URL="https://static-file-global.353355.xyz/goedge/edge-node-linux-${GOARCH}-plus-v${VERSION}.zip"
			TAR_FILE="edge-node-linux-${GOARCH}-plus-v${VERSION}.zip"

			mv /build/run_node.sh ${ROOT_DIR}/run.sh
			;;
		"user")
			TAR_URL="https://static-file-global.353355.xyz/goedge/edge-user-linux-${GOARCH}-v${VERSION}.zip"
			TAR_FILE="edge-user-linux-${GOARCH}-v${VERSION}.zip"

			mv /build/run_user.sh ${ROOT_DIR}/run.sh
			;;
		"dns")
			TAR_URL="https://static-file-global.353355.xyz/goedge/edge-dns-linux-${GOARCH}-v${VERSION}.zip"
			TAR_FILE="edge-dns-linux-${GOARCH}-v${VERSION}.zip"

			mv /build/run_dns.sh ${ROOT_DIR}/run.sh
			;;
		*)
			echo "unknown type: ${1}"
			exit
			;;
	esac
	chmod u+x ${ROOT_DIR}/run.sh

	wget ${TAR_URL} -O ${TAR_FILE}
	unzip ${TAR_FILE}
	rm -f ${TAR_FILE}
}

function clean_apk() {
	apk del wget curl unzip
}

get_arch
install_edges ${1}
clean_apk
