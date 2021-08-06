# v2autosub

一个小小的docker镜像，在v2ray启动前自动获取vmess订阅信息、测量连接情况、并生成包含多个outbound的配置文件。可用于实现自动订阅+负载均衡。

## 如何使用？

```sh
docker run --rm -it -p "1080:1080" -e "SUBSCRIBE_LINK=<你的订阅链接>" yindaheng98/v2autosub
```

## vmess订阅信息是如何获取的？连接情况是如何测量的？

基于[v2gen](https://github.com/iochen/v2gen)

## 配置文件是如何生成的？

配置文件的生成都是基于模板替换的。主要的代码是[`autosub.sh`](autosub.sh)。

在[`autosub.sh`](autosub.sh)中：

1. 首先，对于vmess订阅中的每个服务器，借助[v2gen](https://github.com/iochen/v2gen)的模板功能，用[`templates/outbound.json`](templates/outbound.json)模板生成单独的outbound配置
2. 将每个单独的outbound配置拼接好后替换到[`templates/main.json`](templates/main.json)的`${OUTBOUNDS}`处，然后将生成的tags替换到`${TAGS}`处

所以，在使用脚本时，如果想自定义输出的配置文件的形式，直接将你自己的模板文件挂载到docker容器中覆盖模板文件即可。

## 有哪些可调参数？

见[`Dockerfile`](Dockerfile)：

```Dockerfile
# 订阅链接
ENV SUBSCRIBE_LINK=""

# 自动生成的tag的前缀，tag将以此前缀+数字生成
ENV TAG_PREFIX='v2gen-proxy'

# 生成配置文件的路径
ENV CONFIG_PATH=/etc/v2ray/config.json

# 需要多少个outbound
ENV HOW_MUCH_OUTBOUNDS=4

# 在前多少个outbounds里面选（顺序是v2gen测量结果）
ENV FROM_HOW_MUCH=8

# v2gen的参数：使用多少个线程测量连接情况
ENV THREAD=16

# v2gen的参数：测量多少次取平均值
ENV COUNT=1
```