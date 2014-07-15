#!/bin/sh
# xwq 
# description: Config realserver tunl port and apply arp patch
VIP=192.168.25.41
/etc/rc.d/init.d/functions
case "$1" in
start)
echo "Tunl port starting"
ifconfig tunl0 $VIP netmask 255.255.255.0 broadcast $VIP up
/sbin/route add -host $VIP dev tunl0
echo "1" >/proc/sys/net/ipv4/conf/tunl0/arp_ignore
echo "2" >/proc/sys/net/ipv4/conf/tunl0/arp_announce
echo "1" >/proc/sys/net/ipv4/conf/all/arp_ignore
echo "2" >/proc/sys/net/ipv4/conf/all/arp_announce
sysctl -p
;;
stop)
echo "Tunl port closing"
ifconfig tunl0 down
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 0 > /proc/sys/net/ipv4/conf/all/arp_announce
;;
*)
echo "Usage: $0 {start|stop}"
exit 1
esac