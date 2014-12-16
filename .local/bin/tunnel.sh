#!/bin/sh
if [ "$1" == "" ]; then
  printf "Usage: $0 <hostname>\n\nOpens a SOCKS 4/5 proxy locally on port tcp/1080 through SSH using the server located at <hostname>.\n\n"
  exit 0
fi
ssh -f -N -D 1080 $1 &>/dev/null
CODE=$?
if [ $CODE -eq 0 ]; then
  printf "Tunnel opened.\n"
else
  printf "Failed to open tunnel.\n"
fi
