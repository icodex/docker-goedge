#!/usr/bin/env sh

function set_hosts() {
	cat > /etc/hosts <<END
127.0.0.1 goedge.cn
127.0.0.1 goedge.cloud
127.0.0.1 dl.goedge.cloud
127.0.0.1 dl.goedge.cn
127.0.0.1 global.dl.goedge.cloud
127.0.0.1 global.dl.goedge.cn
END
}

