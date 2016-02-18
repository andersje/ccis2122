#!/bin/bash
/sbin/iptables -F INPUT
/sbin/iptables -P INPUT DROP

/sbin/iptables -F OUTPUT
/sbin/iptables -P OUTPUT ACCEPT

/sbin/iptables -F FORWARD
/sbin/iptables -P FORWARD DROP

MY_IP=10.215.101.1

/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#/sbin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT
#/sbin/iptables -A INPUT -p tcp --dport 80 -j ACCEPT
for port in 22 80 8080 16500 143 1433 ; do
	/sbin/iptables -A INPUT -p tcp -d $MY_IP --dport $port -j ACCEPT
	echo "/sbin/iptables -A INPUT -p tcp -d $MY_IP --dport $port -j ACCEPT"
done

/sbin/iptables -A INPUT -j LOG --log-level warn 
/sbin/iptables -A INPUT -j DROP



/sbin/iptables -I INPUT -i lo -j ACCEPT

