FROM golang:1.15-alpine AS builder
ARG VERSION=v2.0.1
RUN apk add --no-cache git && cd src && \
    git clone https://github.com/yindaheng98/v2autosub && \
    cd v2autosub && go build github.com/yindaheng98/v2autosub

FROM alpine
COPY --from=builder /go/src/v2autosub/v2autosub /bin/v2autosub