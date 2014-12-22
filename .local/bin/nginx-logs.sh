#!/bin/sh

LOG_DEFAULT_PATH="/var/log/nginx/access.log"
LOG_PATH="$1"

if [ "$LOG_PATH" = "" ] && [ -f "$LOG_DEFAULT_PATH" ]; then

  echo -e "\033[35mAuto-detected Log File: \033[32m$LOG_DEFAULT_PATH\033[0m"
  LOG_PATH="$LOG_DEFAULT_PATH"

fi

if [ "$LOG_PATH" = "" ]; then

  echo -e "\033[32mUsage: $0 /path/to/nginx/access_log\033[0m"

else

  # Without vhost:
  #(tail -n 500 -F $LOG_PATH | awk '{printf "\033[40;1;35m%s %s\033[0;37m %s %s \033[31m%s\033[36m %s\033[0m\n", $4, $5, $9, substr($6, 2), $7, $1}')
  # With vhost:
  #(tail -n 500 -F $LOG_PATH | awk '{printf "\033[40;1;35m%s %s\033[0;32m %s \033[37m%s %s \033[31m%s\033[36m %s\033[0m\n", $5, $6, $1, $10, substr($7, 2), $8, $2}')
  (sudo tail -n 500 -F $LOG_PATH | perl -n -e'/^(\S+) (\S+) (\S+) (\S+) \[([^:]+):(\d+:\d+:\d+) ([^\]]+)\]  \"(\S+) (.*?) (\S+)\" (\S+) (\S+) "([^"]*)" "([^"]*)"$/ && print "\033[40;1;35m[$5 $6]\033[0;32m $1 \033[37m$11 $8 \033[31m$9 \033[36m$2\033[0m\n"')

fi
