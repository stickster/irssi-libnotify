#!/bin/bash
for pid in `pgrep -u $UID notify-listener`; do
    DSBA=`cat /proc/$pid/environ | tr '\0' '\n' | grep DBUS_SESSION_BUS_ADDRESS | cut -d '=' -f2-`
    DBUS_SESSION_BUS_ADDRESS=$DSBA exec "$@"
done
