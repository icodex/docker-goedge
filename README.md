# 使用Docker快速部署GoEdge管理平台（包含API节点）和边缘节点

## 部署前的准备工作

### 安装Docker

管理平台和边缘节点都需要先安装Docker，新版本的Docker已包含compose插件，因此我们只需要执行官方推荐的命令安装即可：

```
curl -sSL https://get.docker.com | sh
```

### 部署管理平台

首先编写docker-compose.yaml，因为将管理平台所依赖的mysql加进来，所以这里使用docker compose的方式进行，也是方便后期迁移等管理工作。

mysql的版本要求，官方建议使用mysql 8，最低不低于mysql 5.7.8，系统内存建议4GB以上。

首先进入你想存放docker-compose.yaml的路径，比如/opt/goedge，然后进入该路径后创建docker-compose.yaml，输入以下内容：

```
version: "3"

networks:
  goedge:
    external: false

services:
  mysqld:
    image: mysql:8
    container_name: mysqld
    environment:
      - MYSQL_ROOT_PASSWORD=root
      - MYSQL_USER=edges
      - MYSQL_PASSWORD=edges
      - MYSQL_DATABASE=edges
    networks:
      - goedge
    volumes:
      - ./data/db/mysql:/var/lib/mysql:rw
    restart: always

  edge-admin:
    image: icodex/edge-admin:1.3.3
    container_name: edge-admin
    ports:
      - 7788:7788/tcp
      - 8001:8001/tcp
    networks:
      - goedge
    volumes:
      - ./data/edge-admin/configs:/usr/local/goedge/edge-admin/configs
      - ./data/edge-api/configs:/usr/local/goedge/edge-admin/edge-api/configs
    restart: always
```

以上使用了mysql 8的镜像，接着edge-admin是管理平台的镜像。确定没有端口冲突之后，执行命令启动：

```
docker compose up -d
```

运行后，打开浏览器，输入服务器IP地址和7788端口号，进入安装界面：

![](https://icodex.org/wp-content/uploads/2024/02/WX20240224-231039@2x-1354x800.png)

注意⚠️！因为这里的网络类型是容器内共享的，因此在数据库信息填写这里，数据库的地址只需要填写mysql的容器名即可，比如这里的：mysqld。数据库名、数据库账号、数据库密码均为edges。一直下一步就好了。

![](https://icodex.org/wp-content/uploads/2024/02/WX20240224-231233@2x-953x800.png)

ps：如果你现在的宿主机系统里面已经有mysql，不想再多运行一个浪费资源，则需要考虑删掉docker-compose.yaml里的mysql服务，并将网络类型更改为Host网络类型，以方便与宿主机上的mysql通信，如下：

```
version: "3"

services:
  edge-admin:
    image: icodex/edge-admin:1.3.3
    container_name: edge-admin
    network_mode: host
    volumes:
      - ./data/edge-admin/configs:/usr/local/goedge/edge-admin/configs
      - ./data/edge-api/configs:/usr/local/goedge/edge-admin/edge-api/configs
    restart: always
```

docker-compose.yaml编辑好之后，确定端口没有冲突，就可以执行以下命令启动整个系统了！

### 部署边缘节点

在上面的部署中，已经完成了管理平台的部署，这时可以按照官方教程添加边缘节点的方式进行添加。也可以按以下步骤，部署一个Docker容器形态的边缘节点。

这里使用GoEdge的自动注册功能，因此需要先在GoEdge管理界面 – 边缘节点 – 找到你所在集群 – 集群节点 – 安装升级 – 自动注册，把endpoints、clusterId、secret三个值记录下来。

![](https://icodex.org/wp-content/uploads/2024/02/WX20240224-230019@2x-1353x800.png)

然后准备一个docker-compose.yaml，输入以下内容，注意替换环境变量里相应的值

```
version: "3"

services:
  edge-node:
    image: icodex/edge-node:1.3.3
    container_name: edge-node
    environment:
      - ENDPOINTS=http://xxx.com:8001
      - CLUSTERID=xxx
      - SECRET=xxx
    network_mode: host
    cap_add:
      - NET_ADMIN
    volumes:
      - ./data/edge-node/cache:/opt/cache
      - ./data/edge-node/configs:/usr/local/goedge/edge-node/configs
    restart: always
```

接着使用docker compose命令启动它，很快就可以在管理平台看到这台上线的主机了。

以上，是完整部署GoEdge的全部步骤，非常简单吧！

## 最后

这个项目应该不算造轮子，只是我个人习惯使用docker进行服务的管理，docker运行毕竟套了多一层虚拟化，因此在边缘节点的容器的网络选择上，建议使用host类型，与宿主机共享会比较好。
