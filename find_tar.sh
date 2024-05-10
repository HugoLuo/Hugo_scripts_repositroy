#!/usr/bin/bash

# description: 查找文件夹里以txt结尾的文件，
    # 1.批量修改文件名，xxx.txt 改为 xxx.txt.bak
    # 2.把所有的xxx.txt.bak 文件打包压缩为123.tar.gz
    # 3.批量还原文件的名，即把增加的.bak 再删除
    
# 查找并修改文件名：    
# find /tmp/onefolder/ -type f -name "*.txt"|xargs -i mv {} {}.bak
# find /tmp/onefolder/ -type f -name "*.txt" -exec mv {} {}.bak \;

#将查找的文件列表保存到一个文件里
find /tmp/onefolder/ -name "*.txt" -type f >/tmp/find_list.txt

#遍历列表文件，逐一更改文件的名称
for file in `cat /tmp/find_list.txt`
do
    mv $file $file.bak
done

for file in `cat /tmp/find_list.txt `
do
    echo $file.bak
done > /tmp/find_list.bak.txt

tar -cvzf 123.tar.gz `cat /tmp/find_list.bak.txt|xargs `

for file in `cat  /tmp/find_list.txt`
do
    mv $file.bak $file
done


