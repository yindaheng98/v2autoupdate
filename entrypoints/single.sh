#!/bin/sh
/scripts/autosub.balancer.sh $SUBSCRIBE_LINK $CONFIG_PATH
exec "$@"
