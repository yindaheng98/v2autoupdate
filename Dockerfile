FROM yindaheng98/v2autosub AS v2autosub
FROM v2fly/v2fly-core
COPY --from=v2autosub /bin/v2autosub /bin/v2autosub
COPY *.sh /
RUN chmod +x /*.sh

# 以下环境变量分别对应autosub中的命令行参数
# 对应 -u 参数
ENV URL=

# 对应 -c 参数
ENV COUNT=4

# 对应 -max 参数
ENV MAX=12

# 对应 -node_template 参数
ENV NODE_TMPL=

# 对应 -nodes_template 参数
ENV NODES_TMPL=

# 对应 -thread 参数
ENV THREAD=16

CMD [ "/main.sh" ]