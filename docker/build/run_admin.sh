#!/usr/bin/env sh

. /build/set_hosts.sh

cat <<EOF
"开心版激活方式"
"浏览器访问管理平台，依次点击「系统设置」，「商业版本」，「激活」，直接粘贴下方提供的旗舰版注册码即可完成离线激活，终身有效；"
"或者参考此篇提供的五种获取注册码的方式：https://www.nodeseek.com/post-138160-1"

"F4BuVYEKSDWV+I13ISd5NUyBcWOlH0af4/ow9obzYBS3XvYC9IsK86k5UDyyBv9vqJWN2/FQTDbPyuAO0zxYlkLDC0c8rrShs+7PAkqM0O8wBIGknzForgidDZahky5Lo/ZWaPZ1dVFUxmV29ykb0I0b4tv7Q3OtnTylOuzf//MYrlvyw6VJQMGnsttmeHzsNL/r0yDONOEXZoGoLZsuBKnkfXt+qt6bZF+kM1ncbh+sY42BrPTWQ12sXqJS3qHlzU0FFl9lTNzLGYYhq5vi/4sJuPVE50/uLCtslTJdb9zOGR915hnM+jHYsR+jUk0QxOqtreaHpsvNuLkexXbkmA==")

EOF

set_hosts
ROOT_DIR='/usr/local/goedge'
${ROOT_DIR}/edge-admin/bin/edge-admin
