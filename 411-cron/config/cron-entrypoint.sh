#!/bin/bash
#
#touch /var/spool/cron/crontabs/root
#
#if [ -n "$1" ]; then
#  args=("$@")
#  argn=$#
#
#  for i in $(seq $argn)
#  do
#    echo "${args[$i-1]}" >> /var/spool/cron/crontabs/root
#  done
#fi
#
#cp /var/spool/cron/crontabs/root /tmp/temp.txt
#printenv | cat - /tmp/temp.txt | tee /var/spool/cron/crontabs/root
#chmod 600 /var/spool/cron/crontabs/root
#
#cron -f

while [ true ]
do
    /usr/bin/php /var/www/411/bin/cron.php
    echo "cron.php completed"
    /usr/bin/php /var/www/411/bin/worker.php
    echo "worker.php completed"
    sleep 60
done