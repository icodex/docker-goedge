# GoEdge CDN v1.3.9 纯净开心版部署指南 --人人都有企业运营级CDN系统

## 前情提要

众所周知，GoEdge是一套开源CDN系统，包含开源免费的社区版及付费的商业版。前段时间爆出其已被原作者超哥转让给方能系（黑产），且在其边缘节点程序最新版本v1.4.1中投毒（**包括社区版及商业版在内的所有版本**），即在客户创建的加速站点引入第三方（方能系）恶意JS脚本，**导致客户网站将在某些特定情况下被重定向至违法网站**。

目前发现GoEdge v1.3.9存在两个发行版，根据种种迹象表明，v1.3.9（第一版）可能是原作者超哥维护的最后一个版本，较为安全；而第二版及后续版本则极有可能已不再安全，强烈不建议使用。

即使官方目前已经发表所谓“澄清声明”，且声称最新版本中已“修复”投毒问题，**但信任一旦崩塌就难以重建，建议所有已经安装使用GoEdge v1.3.9以上版本（或安装/更新时间晚于2024年5月20日）的用户回退到 v1.3.9 安全版本**，可参考奶昔制作的回退方案：[https://bbs.naixi.net/thread-110-1-1.html](https://www.nodeseek.com/jump?to=https%3A%2F%2Fbbs.naixi.net%2Fthread-110-1-1.html)

如果你还没有安装过GoEdge，可根据本文档流程手动部署 v1.3.9 纯净版本（由 [@DigitalVirt](https://www.nodeseek.com/member?t=DigitalVirt) 提供的存档），并轻易地通过离线激活GoEdge旗舰版终身授权，实现人手一套企业运营级CDN，真正让闲置小鸡发光发热。由于是官包+注册码离线激活，且屏蔽了官方域名通信，存在后门的概率不大。

## 管理平台安装（必要）

**安装unzip**

-   在CentOS（5、6、7）下可以使用：

```
sudo yum -y install unzip
```

-   RedHa/CentOS 8/CentOS 9/RockyLinux9/Fedora下可以使用：

```
dnf -y install unzip
```

-   在Debian/Ubuntu下可以使用：

```
sudo apt install unzip
```

-   在Freebsd下可以使用：

```
pkg install unzip
```

**屏蔽官方域名**

```
echo "127.0.0.1 goedge.cloud" | sudo tee -a /etc/hosts &gt; /dev/null
echo "127.0.0.1 goedge.cn" | sudo tee -a /etc/hosts &gt; /dev/null
echo "127.0.0.1 dl.goedge.cloud" | sudo tee -a /etc/hosts &gt; /dev/null
echo "127.0.0.1 dl.goedge.cn" | sudo tee -a /etc/hosts &gt; /dev/null
echo "127.0.0.1 global.dl.goedge.cloud" | sudo tee -a /etc/hosts &gt; /dev/null
echo "127.0.0.1 global.dl.goedge.cn" | sudo tee -a /etc/hosts &gt; /dev/null
cat /etc/hosts
```

-   或手动修改hosts文件

```
vi /etc/hosts
```

```
127.0.0.1 goedge.cn
127.0.0.1 goedge.cloud
127.0.0.1 dl.goedge.cloud
127.0.0.1 dl.goedge.cn
127.0.0.1 global.dl.goedge.cloud
127.0.0.1 global.dl.goedge.cn
```

**创建安装目录**

```
mkdir  /usr/local/goedge
cd /usr/local/goedge
```

**获取程序包并解压**

```
# X86_64
wget https://static-file-global.353355.xyz/goedge/edge-admin-linux-amd64-plus-v1.3.9.zip

# aarch64
wget https://static-file-global.353355.xyz/goedge/edge-admin-linux-arm64-plus-v1.3.9.zip
```

```
unzip -o ./edge-admin-linux-amd64-plus-v1.3.9.zip
```

**启动管理平台**

```
cd edge-admin/
bin/edge-admin start
```

如果没有意外的话，服务就正常启动了，并提示类似于以下的信息：

```
Edge Admin started ok, pid: 109053
```

可以使用ps命令，来检查进程是否存在：

```
ps ax|grep edge
```

可以看到类似于以下的进程信息：

```
31643 ?        Sl     0:04 bin/edge-admin
```

就说明管理平台启动成功；可以在 logs/run.log 中查看启动的日志，方便我们诊断问题；  
默认启动的端口是 7788，确认进程已经启动的时候，可以在浏览器上通过：

```
http://IP地址:7788/
```

访问管理平台；如果你的服务器上已经设置了防火墙，需要在防火墙设置 7788 这个端口是通过的；如果能正常访问上述网址的话，系统会自动进入安装过程，按照界面提示填写各项选项即可。

**安装系统服务**

```
bin/edge-admin service
```

**安装MySQL**

```
sudo curl -s https://static-file-global.353355.xyz/goedge/mysql/install-mysql.sh | bash
```

**替换边缘节点包**

```
cd /usr/local/goedge/edge-admin/edge-api/deploy
rm -rf *.zip

wget -O edge-node-linux-amd64-v1.3.9.zip https://static-file-global.353355.xyz/goedge/edge-node-linux-amd64-plus-v1.3.9.zip
wget -O edge-node-linux-arm64-v1.3.9.zip https://static-file-global.353355.xyz/goedge/edge-node-linux-arm64-plus-v1.3.9.zip
```

**开心版激活**

浏览器访问管理平台，依次点击「系统设置」，「商业版本」，「激活」，直接粘贴下方提供的旗舰版注册码即可完成离线激活，终身有效；或者参考此篇提供的五种获取注册码的方式：[https://www.nodeseek.com/post-138160-1](https://www.nodeseek.com/post-138160-1)

```
F4BuVYEKSDWV+I13ISd5NUyBcWOlH0af4/ow9obzYBS3XvYC9IsK86k5UDyyBv9vqJWN2/FQTDbPyuAO0zxYlkLDC0c8rrShs+7PAkqM0O8wBIGknzForgidDZahky5Lo/ZWaPZ1dVFUxmV29ykb0I0b4tv7Q3OtnTylOuzf//MYrlvyw6VJQMGnsttmeHzsNL/r0yDONOEXZoGoLZsuBKnkfXt+qt6bZF+kM1ncbh+sY42BrPTWQ12sXqJS3qHlzU0FFl9lTNzLGYYhq5vi/4sJuPVE50/uLCtslTJdb9zOGR915hnM+jHYsR+jUk0QxOqtreaHpsvNuLkexXbkmA==
```

## 边缘节点安装（安装在你的CDN节点上）

浏览器访问管理平台，依次点击「边缘节点」，「创建节点」，按要求填入节点名称、节点公网IP地址、SSH端口号，添加SSH登录信息，点击「远程安装」，即可一键完成边缘节点安装部署。

由于上面的流程已经替换过/deploy目录下的边缘节点包，故此处一键安装的边缘节点程序版本都是安全版本，无需担忧。

**安装成功后，建议参照安装管理平台时的操作，前往已安装的节点手动修改hosts屏蔽与官方域名的通信！**

## 用户平台安装（非必要，仅商业化运营需要）

**转到安装目录**

```
cd /usr/local/goedge
```

**获取程序包并解压**

```
# X86_64
wget https://static-file-global.353355.xyz/goedge/edge-user-linux-amd64-v1.3.9.zip

# aarch64
wget https://static-file-global.353355.xyz/goedge/edge-user-linux-arm64-v1.3.9.zip
```

```
unzip -o ./edge-user-linux-amd64-v1.3.9.zip
```

**管理平台添加用户节点**

浏览器访问管理平台，依次点击「系统设置」，「高级设置」，「用户节点」，「添加节点」，节点名称任意填写，进程监听端口及外部访问地址端口建议保持一致，官方文档建议可填写80/443。

创建完毕后点击「安装节点」，可以看到配置文件内容信息，复制全部内容留作下步备用。

**创建配置文件**

```
vi /usr/local/goedge/edge-user/configs/api_user.yaml
```

粘贴上步获取到的配置文件内容信息，保存并退出。

**启动用户平台**

```
cd edge-user/
bin/edge-user start
```

**安装系统服务**

```
bin/edge-user service
```

**如果你的用户平台并非与管理平台安装在同一台服务器，安装成功后，建议参照安装管理平台时的操作，前往已安装的节点手动修改hosts屏蔽与官方域名的通信！**

## 智能DNS模块安装（非必要）

**转到安装目录**

```
cd /usr/local/goedge
```

**获取程序包并解压**

```
# X86_64
wget https://static-file-global.353355.xyz/goedge/edge-dns-linux-amd64-v1.3.9.zip

# aarch64
wget https://static-file-global.353355.xyz/goedge/edge-dns-linux-arm64-v1.3.9.zip
```

```
unzip -o ./edge-dns-linux-amd64-v1.3.9.zip
```

**管理平台添加DNS节点**

浏览器访问管理平台，依次点击「智能DNS」，「集群管理」（首次需要先创建一个集群，名称随意），然后点击「创建节点」，按要求填入节点名称、节点公网IP地址。

创建完毕后点击创建好的节点名称，点击「安装节点」，可以看到配置文件内容信息，复制全部内容留作下步备用。

**创建配置文件**

```
vi /usr/local/goedge/edge-dns/configs/api_dns.yaml
```

粘贴上步获取到的配置文件内容信息，保存并退出。

**启动用户平台**

```
cd edge-dns/
bin/edge-dns start
```

**安装系统服务**

```
bin/edge-dns service
```

**如果你的智能DNS模块并非与管理平台安装在同一台服务器，安装成功后，建议参照安装管理平台时的操作，前往已安装的节点手动修改hosts屏蔽与官方域名的通信！**

## 常用指令

**端口占用查询**

```
sudo netstat -tuln | grep :53
```

**解除53端口占用**

```
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved
```

```
sudo rm /etc/resolv.conf
sudo touch /etc/resolv.conf
```

```
vi /etc/resolv.conf
```

```
nameserver 8.8.8.8
nameserver 8.8.4.4
```

## 本文档使用的GoEdge存档镜像

[https://drive.google.com/drive/folders/1-2JbKiNy-MWF7RLnIUIRXiT-AE37rUDx](https://www.nodeseek.com/jump?to=https%3A%2F%2Fdrive.google.com%2Fdrive%2Ffolders%2F1-2JbKiNy-MWF7RLnIUIRXiT-AE37rUDx)  
感谢 [@DigitalVirt](https://www.nodeseek.com/member?t=DigitalVirt) 提供的存档，已与 [dl.naixi.net](https://www.nodeseek.com/jump?to=http%3A%2F%2Fdl.naixi.net) 等多个源提供的包进行MD5校验结果一致，应该没有大问题。

## 官方文档

出现任何问题，可参考官方文档说明：[https://goedge.cloud/docs](https://www.nodeseek.com/jump?to=https%3A%2F%2Fgoedge.cloud%2Fdocs)