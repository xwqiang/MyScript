#!/bin/sh
# description: start LVS of Directorserver
VIP=192.168.25.41
#（注意，lvs server那台机器2个ip，一个是vip,一个是本身ip例如192.168.25.42）
RIP1=192.168.25.44
RIP2=192.168.25.45
#RIPn=192.168.0.n
GW=192.168.25.254
/etc/rc.d/init.d/functions
case "$1" in
start)
echo " start LVS of DirectorServer"
# set the Virtual IP Address
/sbin/ifconfig tunl0 $VIP broadcast $VIP netmask 255.255.255.255 up
/sbin/route add -host $VIP dev tunl0
#Clear IPVS table
/sbin/ipvsadm -C
#set LVS
/sbin/ipvsadm -A -t $VIP:80 -s rr
/sbin/ipvsadm -a -t $VIP:80 -r $RIP1:80 -i
/sbin/ipvsadm -a -t $VIP:80 -r $RIP2:80 -i
#/sbin/ipvsadm -a -t $VIP:80 -r $RIP3:80 -i
#Run LVS
/sbin/ipvsadm
#end
;;
stop)
echo "close LVS Directorserver"
ifconfig tunl0 down
/sbin/ipvsadm -C
;;
*)
echo "Usage: $0 {start|stop}"
exit 1
esac