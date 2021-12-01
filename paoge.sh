#!/bin/bash
### 常规操作，添加系统函数
. /etc/init.d/functions
### 前置操作系统判断
os_v(){
uname -a|awk -F" u|c|C|-" '{print $2}'
}
### CentOS7和8关闭防火墙

disable_78fw(){
systemctl disable --now firewalld &> /dev/null
action "CentOS`os_v`防火墙已关闭!"
}

### CentOS6关闭防火墙
disable_6fw(){
chkconfig iptables off
action "CentOS`os_v`防火墙已关闭!"
}
### Ubuntu20关闭防火墙
#disable_U20(){
#sudo systemctl diskable --now ufw &> /dev/null
#action "Ubuntu`os_v`防火墙已关闭!"   
#}

if [ `os_v` -eq 6 ];then 
	disable_6fw
#elif [ $ov -eq 20 ];then 
#	disable_U20
else
	disable_78fw
fi
echo "`hostname`关闭防火墙完成"

### 时间同步
d=`curl -Ss https://www.bt.cn/api/index/get_date`
if [ "$d" = "" ];then
    echo '时间同步失败!';
    echo $d;
fi
date -s "$d"
echo "时间同步成功!"
