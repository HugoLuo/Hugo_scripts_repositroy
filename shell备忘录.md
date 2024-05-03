## <center>Shell工作备忘录</center>

- 1.read函数

 -p:指定读取时的提示符<p/>
 -t:指定读取时等待的时间（以秒为单位）</p>
 -s:表示读取时以安全不显示出来，一般用于提示将输入的是密码等敏感信息 </p>
```javascript
read -p "Please enter your name:" -t 10 var_name  
read -p "Please enter your password:" -s var_passwd
```

- 2.也用于在while循环时设置断点

rpm 

rpm -qi bash
rpm -ql bash
rpm -qa bash	
rpm -qc bash #查看配置文件


### 关联数组

* 定义关联数组：一般数组用数字【0，1，2.。。】做索引 </p>
            关联数组用key【字符串/名字】做索引。

``` javascript
	declare -A singer
		singer=([name]=hugo [age]=42 [address]=Guangzhou)
	declare -A song
		song=([name]=frinds [type]=public [period]=90)

	echo ${singer[name]}
	echo ${singer[@]}
	echo ${#singer[@]}
	echo ${!singer[@]}

```
使用关联数据统计TCP连接的状态：
``` 
netstat -nat|awk '/^tcp/ {++arr[$NF]};END {for(k in arr) print k,"\t",arr[k]}' 
```


keyword: 脚本中向指定文件写入内容
```
#!/usr/bin/bash
cat > 20240428.txt <<EOF
Hello,world! 20240428
EOF
```
一些经典的用法：
* [信息来源](https://blog.csdn.net/m0_52165864/article/details/126291551) </p>
1.统计http status:
```
cat access.log|awk '{count[$(9)]+=1};END {for (code in count) print code,counts[code]}'
cat access.log|awk '{print $9}'|sort|uniq -c|sort -rn
```
2.统计404
```
awk '($9~/404/)' access.log |awk '{print $9,$7}'|sort
```
3.网站日志分析（nginx日志）
 - 3.1 获取访问前10的IP地址 <br>
  	sort -k2 -nr ## -k2 按照第二排进行排序;-nr 将按数字进行倒序（反向）排序。</p>
  	uniq -c ## -c是count,检查文件过滤掉重复的行，并在行首显示重复出现的次数 </p>
```
  cat access.log|awk '{print $1}'|sort|uniq -c |sort -nr|head -10
  	grep -v '^$' #去除空行
```
  3.2 获取前20访问次数最多的页面或文件 ，及访问IP
```
  cat access.log|awk '{print $11}'|sort|uniq -c|sort -nr|head -20
```
 4.用tcpdump 嗅探80端口的访问
``` 
 tcpdump -i ens33 dst port 80 -c 1000|awk -F"." '{print $1,$2,$3,$4}'|sort|uniq -c|sort -nr|head -20
``` 
5.根据端口列线程
```
  netstat -lnpt|grep 80|awk '{print $7}'|cut -d/ -f1
``` 
6.查找较多time_wait 连接
``` 
netstat -n|grep TIME_WAIT|sort|uniq -c|sort -nr|head -20
```







