FROM yindaheng98/v2gen AS v2gen
FROM v2fly/v2fly-core
COPY --from=v2gen /bin/v2gen /bin/v2gen
COPY scripts /scripts
COPY templates /templates
RUN apk add --no-cache expect && chmod +x /scripts/*
ENV THREAD=16
ENV COUNT=1

CMD [ "/usr/bin/v2ray", "-config", "/etc/v2ray/config.json" ]