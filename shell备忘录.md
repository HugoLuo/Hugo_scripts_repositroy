<center>Shell工作备忘录</center>
## 1.read函数

read 
  
 -p:指定读取时的提示符
 -t:指定读取时等待的时间（以秒为单位）
 -s:表示读取时以安全不显示出来，一般用于提示将输入的是密码等敏感信息 
read -p "Please enter your name:" -t 10 var_name  
read -p "Please enter your password:" -s var_passwd

也用于在while循环时设置断点


rpm 

rpm -qi bash
rpm -ql bash
rpm -qa bash	
rpm -qc bash #查看配置文件


关联数组

定义关联数组：一般数组用数字【0，1，2.。。】做索引
            关联数组用key【字符串/名字】做索引。
	declare -A singer
		singer=([name]=hugo [age]=42 [address]=Guangzhou)
	declare -A song
		song=([name]=frinds [type]=public [period]=90)

	echo ${singer[name]}
	echo ${singer[@]}
	echo ${#singer[@]}
	echo ${!singer[@]}



keyword:  脚本中向指定文件写入内容

#!/usr/bin/bash
cat > 20240428.txt <<EOF
Hello,world! 20240428
EOF





