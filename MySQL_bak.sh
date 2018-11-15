#!/bin/bash

#Description:This script for backup the MySQL Database.
#DATE:2018-11-15
#Autor:Hugo Luo
#Version:1.0

TIME=$(date +20%y-%m-%d_%H%M%S -d -3minute)
DATE=$(date +20%y%m%d)
BackupPath=/home/tpdusr/databackup/${DATE}
LOGFILE=/home/tpdusr/databackup/databackup.log
HOST=128.17.25.79
USER=root
PASSWORD=Tfd@123456
Database=zs

function bak_db(){
	echo -e "\n" >> LOGFILE
	echo "====================================" >> $LOGFILE
	echo "BACKUP TIME:${TIME}" >> $LOGFILE
	mysqldump -u$USER -p$PASSWORD --database ${Database} > $BackupPath/${TIME}_${Database}.mysql
	if [[ $? -eq 0 ]];then
		echo "$TIME the DB ${Database} backup successed" >> $LOGFILE
		exit 0
	else
		echo "Error: $TIME the DB ${Database} backup failed , please checked" >> $LOGFILE
	fi

}

if [ -e $BackupPath ];then
	echo "Exist the dail folder"
	bak_db
else
	mkdir -p ${BackupPath}
	bak_db
fi
