#!/bin/bash

HOST="$1"
PATH="$2"
ADDRESS="$3"
PORT="$4"
SSL=""

[ "$HOST"    == "" ] && printf "Usage: $0 <host> <path> [real-host]\n" && exit 1
[ "$PATH"    == "" ] && printf "Usage: $0 <host> <path> [real-host]\n" && exit 1
[ "$ADDRESS" == "" ] && ADDRESS="$HOST"
[ "$PORT"    == "" ] && PORT="80"
[ "$PORT" == "443" ] && SSL=" --ssl"

DATA_STREAM="GET ${PATH} HTTP/1.1\nAccept: */*\nConnection: close\nHost: ${HOST}\nUser-Agent: User-Agent: curl/7.37.0\n\n"

i=0
while true; do
  i=$((i+1))
  printf "== %-4s =======================================================================\n" "$i"
  printf "${DATA_STREAM}"
  printf "${DATA_STREAM}" | /usr/bin/nc${SSL} --crlf --send-only -w 100ms ${ADDRESS} ${PORT}
done
