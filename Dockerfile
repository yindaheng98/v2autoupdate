FROM yindaheng98/v2gen AS v2gen
FROM v2fly/v2fly-core
COPY --from=v2gen /bin/v2gen /bin/v2gen
COPY default_templates /templates
COPY entrypoint.sh /entrypoint.sh
COPY autosub.sh /autosub.sh
RUN chmod +x /entrypoint.sh
RUN apk add --no-cache expect && chmod +x /entrypoint.sh && chmod +x /autosub.sh
ENV THREAD=16
ENV COUNT=1
ENV TAG_PREFIX='v2gen-proxy'

# 订阅链接
ENV SUBSCRIBE_LINK=""

# 生成配置文件的路径
ENV CONFIG_PATH=/etc/v2ray/config.json

# 需要多少个outbound
ENV HOW_MUCH_OUTBOUNDS=4

# 在前多少个outbounds里面选
ENV FROM_HOW_MUCH=8

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "/usr/bin/v2ray", "-config", "/etc/v2ray/config.json" ]