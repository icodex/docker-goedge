#!/usr/bin/env sh

ROOT_DIR='/usr/local/goedge'

function pre_config() {
    if [ ! -e ${ROOT_DIR}/edge-node/configs/api_cluster.yaml ]; then
        touch ${ROOT_DIR}/edge-node/configs/api_cluster.yaml
cat >> ${ROOT_DIR}/edge-node/configs/api_cluster.yaml << EOF
rpc.endpoints: [ "${ENDPOINTS}" ]
clusterId: "${CLUSTERID}"
secret: "${SECRET}"
EOF
    fi
}

mkdir -p /opt/cache
chmod 777 /opt/cache

pre_config
${ROOT_DIR}/edge-node/bin/edge-node
