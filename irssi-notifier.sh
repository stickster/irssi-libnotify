#!/bin/bash
NLPID=$(pgrep -n -u "$UID" notify-listener)
if [ ! -z "$NLPID" ]; then
    DSBA=$(tr '\0' '\n' < "/proc/$NLPID/environ" | sed -n s/DBUS_SESSION_BUS_ADDRESS=//p)
    DBUS_SESSION_BUS_ADDRESS=$DSBA exec "$@"
fi
