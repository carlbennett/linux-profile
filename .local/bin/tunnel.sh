#!/bin/bash
HOSTNAME="$1"
PORT="$2"
[ "$HOSTNAME" == "" ] && printf "Usage: $0 <hostname> [port]\n\nOpens a SOCKS 4/5 proxy over SSH.\n" && exit 1
[ "$PORT"     == "" ] && PORT="1080"
RESULT=`ps aux | grep ".*ssh.*${PORT}.*${HOSTNAME}.*" | grep -v grep`
[ "$RESULT" ] && kill `printf "$RESULT" | awk {'print $2'}` && printf "Killed old tunnel.\n"
ssh -f -N -D "$PORT" "$HOSTNAME" &>/dev/null
CODE=$?
[ "$CODE" -eq 0 ] && printf "Tunnel opened.\n" && exit "$CODE"
[ "$CODE" -ne 0 ] && printf "Failed to open tunnel.\n" && exit "$CODE"
