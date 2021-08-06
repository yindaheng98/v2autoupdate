FROM yindaheng98/v2autosub
COPY entrypoints/single.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 订阅链接
ENV SUBSCRIBE_LINK=""

# 生成配置文件的路径
ENV CONFIG_PATH=/etc/v2ray/config.json







ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/bin/v2ray", "-config", "/etc/v2ray/config.json" ]