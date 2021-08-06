# v2autosub

一个小小的docker镜像，在v2ray启动前自动获取vmess订阅信息、测量连接情况、并生成单outbound或多outbound负载均衡配置文件

## vmess订阅信息是如何获取的？连接情况是如何测量的？

基于[v2gen](https://github.com/iochen/v2gen)

## 配置文件是如何生成的？

配置文件的生成都是基于模板替换的。

1. 首先，对于vmess订阅中的每个服务器，借助[v2gen](https://github.com/iochen/v2gen)的模板功能，用[`templates/outbound.json`](templates/outbound.json)模板生成单独的outbound配置
2. `scripts/autosub.single.sh`是生成单服务器模式配置文件的脚本，它只生成一个outbound配置，将其替换到[`templates/autosub.single.json`](templates/autosub.single.json)的`${OUTBOUND}`处，并将tag前缀替换到`${SELECTOR}`处
3. `scripts/autosub.balancer.sh`是生成负载均衡模式配置文件的脚本，它会生成多个outbound配置，将其拼接好后替换到[`templates/autosub.balancer.json`](templates/autosub.balancer.json)的`${OUTBOUNDS}`处，并将tag前缀替换到`${SELECTORS}`处

所以，在使用脚本时，如果想自定义输出的配置文件的形式，直接将你自己的模板文件挂载到docker容器中覆盖模板文件即可。

## 如何使用？

