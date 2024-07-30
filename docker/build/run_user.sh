#!/usr/bin/env sh

. /build/set_hosts.sh

function pre_config() {
    if [ ! -e ${ROOT_DIR}/edge-user/configs/api_user.yaml ]; then
        touch ${ROOT_DIR}/edge-user/configs/api_user.yaml
cat >> ${ROOT_DIR}/edge-user/configs/api_user.yaml << EOF
rpc.endpoints: [ "${ENDPOINTS}" ]
nodeId: "${NODEID}"
secret: "${SECRET}"
EOF
    fi
}

ROOT_DIR='/usr/local/goedge'

set_hosts
pre_config
${ROOT_DIR}/edge-user/bin/edge-user
