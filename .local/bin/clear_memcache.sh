#!/bin/sh
HOST=$1
PORT=$2
[ "$HOST" == "" ] && HOST="localhost"
[ "$PORT" == "" ] && PORT=11211
echo "flush_all" | nc $HOST $PORT
