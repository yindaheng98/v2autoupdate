#!/bin/sh
# $1 是订阅链接
# $2 是生成配置文件的路径
# $3 是需要多少个outbound
# $4 是在前多少个outbound里面选
OUTBOUNDS=''
TAGS=''
for i in $(seq 1 $3); do
    UUID=$(cat /proc/sys/kernel/random/uuid)
    TEMP=/tmp/${UUID}.json
    expect << EOF
    set timeout -1
    spawn v2gen -u "$1" -o $TEMP -template /templates/outbound.json -thread $THREAD -c $COUNT
    expect "Please Select:"
    send "$(expr $RANDOM % $4)\n"
    expect "config has been written to"
EOF
    TAG="$TAG_PREFIX$i"
    content=$(cat "$TEMP")
    eval "cat <<EOF
    $content" >"$TEMP"
    OUTBOUND=$(cat "$TEMP")
    rm "$TEMP"
    OUTBOUNDS="$OUTBOUND,$OUTBOUNDS"
    TAGS="\"$TAG\",$TAGS"
done
content=$(cat /templates/main.json)
eval "cat <<EOF
$content
EOF" >"$2"
echo "Your config file is:"
cat "$2"
