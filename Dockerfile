FROM yindaheng98/v2gen AS v2gen
FROM v2fly/v2fly-core
COPY --from=v2gen /bin/v2gen /bin/v2gen
COPY default_templates /templates
COPY entrypoint.sh /entrypoint.sh
COPY autosub.sh /autosub.sh
RUN chmod +x /entrypoint.sh
RUN apk add --no-cache expect && chmod +x /entrypoint.sh && chmod +x /autosub.sh

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

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "/usr/bin/v2ray", "-config", "/etc/v2ray/config.json" ]