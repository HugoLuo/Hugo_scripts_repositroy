#!/bin/bash

#Description:This script  is monitor the memcache process status, once the memcache is down ,it will auto restart in 3 minutes.
#DATE:2018-11-14
#Autor:Hugo Luo
#Version:1.0

TIME=$(date +20%y-%m-%d_%H%M%S)

MEMCACHED=`which memcached`

LOG=/home/hugo/scripts/logs/monitor_memcache.log

ps -ef|grep memcache|grep -v grep|wc -l > /home/hugo/scripts/memcache_process
netstat -lnpt|grep 11211|wc -l > /home/hugo/scripts/memcache_port_numbers
MEMCACHE_PROSS=`cat /home/hugo/scripts/memcache_process`
MEMCACHE_PORT=`cat /home/hugo/scripts/memcache_port_numbers`




function start_memcache(){
	if [[ ${MEMCACHE_PROSS} -ge 1 ]];then
		if [[ $MEMCACHE_PORT -ge 2 ]];then
			echo "===================================" >> ${LOG}
			echo "${TIME} memcache is running normal" >> ${LOG}
		else
			echo "===================================">> ${LOG}
			echo "${TIME} memcache port is not listening, and will try to restart the memcache..." >> ${LOG}
			${MEMCACHED} –d –l 172.16.115.121 –p 11211 –u root –m 64 –c 1024 -P /home/hugo/memcached.pid
		fi
	else
		echo "===================================" >> ${LOG}
		echo "${TIME} memcache process are not running" >> ${LOG}
	        ${MEMCACHED} –d –l 172.16.115.121 –p 11211 –u root –m 64 –c 1024 -P /home/hugo/memcached.pid
	fi
}

start_memcache
