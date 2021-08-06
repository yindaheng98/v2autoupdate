#!/bin/sh
/scripts/autosub.balancer.sh $SUBSCRIBE_LINK $CONFIG_PATH $HOW_MUCH_OUTBOUNDS $FROM_HOW_MUCH
exec "$@"
