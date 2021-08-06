FROM yindaheng98/v2autosub
COPY entrypoints/balancer.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

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