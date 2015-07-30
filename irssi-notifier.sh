#!/usr/bin/env bash
NLPID=$(pgrep -u "${UID}" notify-listener) || exit 0
DBUS_SESSION_BUS_ADDRESS_EXPR=$( xargs --null --max-args=1 echo < "/proc/${NLPID}/environ" | grep DBUS_SESSION_BUS_ADDRESS) || exit 0
DBUS_SESSION_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS_EXPR#*=}" exec "$@"
