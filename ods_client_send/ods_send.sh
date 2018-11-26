#!/bin/bash

#Description:this script is for upload file to te CD Server via CDSend command
#Author:Hugo Luo
#Date:2018-11-20
#Version:1.0

source /etc/profile
. ~/.profile

datedir=$(date +20%y%m%d)
batchdir="/home/tpdusr/data/tmp/root/batch/system01/${datedir}"
batchfile="system01-${datedir}-result.txt"
batchokfile="system01-${datedir}-result-ok.txt"
 
CDSendLog="/home/tpdusr/CDSend.log"
TIME=$(date +20%y%m%d_%H:%M:%S)


echo "${TIME}" >> ${CDSendLog}


TargetDir="/home/ap/ods/file/STA/000/SYD"

SourceNode=`hostname`
TargetNode="CDGDODSFTP"
SourceFile="${batchdir}/${batchfile}"
SourceOKFile="${batchdir}/${batchokfile}"
TargetFile="${TargetDir}/${datedir}/${batchfile}"
TargetOKFile="${TargetDir}/${datedir}/${batchokfile}"
TargetFolder="${TargetDir}/${datedir}"

function checkbatch(){
	if [[ -e ${batchdir}/${batchfile} ]];then
		/home/tpdusr/data/tmp/root/ods/bin/CDSend ${SourceNode} ${TargetNode} ${SourceFile} ${TargetFile} ${TargetFolder}
		if [ $? = 0 ];then
			echo "${batchfile} have send to the server success" >> ${CDSendLog}
		fi
		/home/tpdusr/data/tmp/root/ods/bin/CDSend ${SourceFile} ${TargetNode} ${SourceOKFile} ${TargetOKFile} ${TargetFolder} 
		if [ $? = 0 ];then
			echo "${batchokfile} have send to the server success" >> ${CDSendLog}
		fi
		echo "=======================================================" >> ${CDSendLog}
		mv ${SourceOKFile} ${SourceOKFile}.bak > /dev/null 2>&1
	else
		echo "batch file not found " >> ${CDSendLog}
		return
	fi
}

function main(){
	checkbatch
}

main



