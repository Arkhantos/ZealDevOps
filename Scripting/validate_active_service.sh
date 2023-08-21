#!/bin/bash
mysql=`ps awx | grep 'mysql' |grep -v grep|wc -l`
if [ $mysql == 0 ]; then
    service mysql restart
    echo "Mysql estaba caido y el cron lo reactivo."
fi