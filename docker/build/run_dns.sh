#!/usr/bin/env sh

. /build/set_hosts.sh

function pre_config() {
    if [ ! -e ${ROOT_DIR}/edge-dns/configs/api_dns.yaml ]; then
        touch ${ROOT_DIR}/edge-dns/configs/api_dns.yaml
cat >> ${ROOT_DIR}/edge-dns/configs/api_dns.yaml << EOF
rpc.endpoints: [ "${ENDPOINTS}" ]
clusterId: "${CLUSTERID}"
secret: "${SECRET}"
EOF
    fi
}

ROOT_DIR='/usr/local/goedge'

set_hosts
pre_config
${ROOT_DIR}/edge-dns/bin/edge-dns
