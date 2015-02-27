#!/bin/bash

USAGE_STRING="Usage: $0 <host> <path> [real-host] [port] [user-agent]\n"

HOST="$1"
PATH="$2"
ADDRESS="$3"
PORT="$4"
USER_AGENT="$5"
SSL=""

[ "$HOST"       == ""    ] && printf "$USAGE_STRING" && exit 1
[ "$PATH"       == ""    ] && printf "$USAGE_STRING" && exit 1
[ "$ADDRESS"    == ""    ] && ADDRESS="$HOST"
[ "$PORT"       == ""    ] && PORT="80"
[ "$USER_AGENT" == ""    ] && USER_AGENT="curl/7.37.0"
[ "$PORT"       == "443" ] && SSL=" --ssl"

DATA_STREAM="GET ${PATH} HTTP/1.1\nAccept: */*\nConnection: close\nHost: ${HOST}\nUser-Agent: ${USER_AGENT}\n\n"


i=0
while true; do
  i=$((i+1))
  printf "== %-4s =======================================================================\n" "$i"
  printf "${DATA_STREAM}"
  printf "${DATA_STREAM}" | /usr/bin/nc${SSL} --crlf --send-only -w 100ms ${ADDRESS} ${PORT}
done
