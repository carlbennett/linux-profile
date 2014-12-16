#!/bin/sh
CURL="/usr/bin/curl"
AWK="/usr/bin/awk"
URL="$1"
result=`$CURL -o /dev/null -s -w %{time_connect}:%{time_starttransfer}:%{time_total} $URL`
echo $result | $AWK -F: '{ print $1" "$2" "$3}'
