#!/bin/sh
# $1 是订阅链接
# $2 是生成配置文件的路径
PREFIX='v2gen'
SELECT=0
UUID=$(cat /proc/sys/kernel/random/uuid)
TEMP=/tmp/${UUID}.json
v2gen -u "$1" -o $TEMP -template /templates/outbound.json -best -thread $THREAD -c $COUNT
TAG_PREFIX="$PREFIX-"
content=$(cat "$TEMP")
eval "cat <<EOF
    $content" >"$TEMP"
BALANCER=$(cat "$TEMP")
rm "$TEMP"
SELECTOR="\"$PREFIX\","
content=$(cat /templates/single.json)
eval "cat <<EOF
$content
EOF" >"$2"
echo "Your config file is:"
cat "$2"
