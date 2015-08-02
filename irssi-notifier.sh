#!/usr/bin/env bash
# get the notify-listener's PID:
NLPID=$(pgrep -u "${UID}" notify-listener) || exit 0
# take its DBUS_SESSION_BUS_ADDRESS expression:
DBUS_SESSION_BUS_ADDRESS_EXPR=$(
	xargs \
		--null \
		--max-args=1 \
		echo < "/proc/${NLPID}/environ" \
	| grep DBUS_SESSION_BUS_ADDRESS
) || exit 0
# set our DBUS_SESSION_BUS_ADDRESS to the one we've found above:
DBUS_SESSION_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS_EXPR#*=}" exec "$@"
