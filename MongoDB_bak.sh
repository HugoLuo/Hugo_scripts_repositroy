#!/bin/bash

#Description:This script for backup the MongoDB Database.
#DATE:2018-11-15
#Autor:Hugo Luo
#Version:1.0

DATE=$(date +20%y%m%d)
DUMP=/home/hugo/mongodb_27017/bin/mongodump
TAR_DIR=/home/hugo/databackup/mongodb/${DATE}
HOST=172.16.115.121
USER=root
PASSWORD=root
PORT=27017
AuthDB=admin
DB1=milkyway
DB2=black

function bak_db(){
	
	${DUMP} -h ${HOST} -p ${PASSWORD} --port ${PORT} --authenticationDatabase  ${AuthDB} -d ${DB1} -o ${TAR_DIR}
	db1_success=`echo $?`
	${DUMP} -h ${HOST} -p ${PASSWORD} --port ${PORT} --authenticationDatabase  ${AuthDB} -d ${DB2} -o ${TAR_DIR}
	db2_success=`echo $?`

	success=`expr ${db1_success} + ${db2_success}`

	if [[ success -eq 0 ]];then
		exit 0
	else
		exit 1
	fi
 }

 if [ -e ${TAR_DIR} ];then
 	rm -rf ${TAR_DIR}
 	bak_db
 else
 	bak_db
 fi
