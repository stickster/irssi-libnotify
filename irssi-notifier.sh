#!/bin/bash
NLPID=`pgrep -u $UID notify-listener`
if [ ! -z "$NLPID" ]; then
    DSBA=`cat /proc/$NLPID/environ | tr '\0' '\n' | grep DBUS_SESSION_BUS_ADDRESS | cut -d '=' -f2-`
    DBUS_SESSION_BUS_ADDRESS=$DSBA exec "$@"
fi
