#!/bin/bash

USAGE_STRING="Usage: $0 <host> <path> [real-host] [port] [user-agent]\n"

HOST="$1"
PATH="$2"
ADDRESS="$3"
PORT="$4"
USER_AGENT="$5"
SSL=""
CURL_USER_AGENT=$(/bin/curl --version | /bin/awk '{print $1 "/" $2}' | /bin/sed -n 1p)

[ "$HOST"       == ""    ] && printf "$USAGE_STRING" && exit 1
[ "$PATH"       == ""    ] && printf "$USAGE_STRING" && exit 1
[ "$ADDRESS"    == ""    ] && ADDRESS="$HOST"
[ "$PORT"       == ""    ] && PORT="80"
[ "$USER_AGENT" == ""    ] && USER_AGENT="$CURL_USER_AGENT"
[ "$USER_AGENT" == ""    ] && USER_AGENT="fast_curl"
[ "$PORT"       == "443" ] && SSL=" --ssl"

DATA_STREAM="GET ${PATH} HTTP/1.1\nAccept: */*\nConnection: close\nHost: ${HOST}\nUser-Agent: ${USER_AGENT}\n\n"

NETCAT="/usr/bin/nc"
[ ! -x "$NETCAT" ] && NETCAT="/bin/nc"
[ ! -x "$NETCAT" ] && \
  printf "Error: Cannot execute /usr/bin/nc or /bin/nc.\n" \
  exit 0

i=0
while true; do
  i=$((i+1))
  printf "== %-6s =====================================================================\n" "$i"
  printf "${DATA_STREAM}"
  printf "${DATA_STREAM}" | ${NETCAT}${SSL} --crlf --send-only -w 100ms ${ADDRESS} ${PORT}
done
