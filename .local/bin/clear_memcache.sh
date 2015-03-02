#!/bin/sh
HOST=$1
PORT=$2
PATH=$3
[ "$HOST" == "" ] && HOST="localhost"
[ "$PORT" == "" ] && PORT=11211
[ "$PATH" != "" ] && [ ! -x "$PATH" ] && \
  printf "Error: $PATH is not executeable.\n" \
  exit 0
[ ! -x "$PATH" ] && PATH="/usr/bin/nc"
[ ! -x "$PATH" ] && PATH="/bin/nc"
[ ! -x "$PATH" ] && \
  printf "Error: Cannot execute /usr/bin/nc or /bin/nc.\n" \
  exit 0
echo "flush_all" | $PATH $HOST $PORT
