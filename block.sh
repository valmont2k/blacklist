#!/bin/bash
echo -n "Applying domains..."
ipset flush blacklist
rm -f /etc/blacklist/tmp
xfile=$(cat /etc/blacklist/listdomains.txt)
for dom in $xfile
do

  dig +time=2 +tries=1 @202.12.27.33 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @198.97.190.53 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @192.228.79.201 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @198.41.0.4 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @192.5.5.241 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @192.112.36.4 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @199.7.83.42 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @192.58.128.30 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @192.36.148.17 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @199.7.91.13 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @193.0.14.129 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @192.33.4.12 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @192.203.230.10 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @208.67.222.222 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @8.8.4.4 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @208.67.220.220 $dom +short >> /etc/blacklist/tmp
#  dig +time=2 +tries=1 @82.200.69.80 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @84.200.70.40 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @209.244.0.3 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @209.244.0.4 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @4.2.2.1 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @4.2.2.2 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @4.2.2.3 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @4.2.2.4 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @8.26.56.26 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @8.20.247.20 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @185.121.177.177 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @169.239.202.202 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @77.88.8.8 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @77.88.8.1 $dom +short >> /etc/blacklist/tmp
#  dig +time=2 +tries=1 @ $dom +short >> /etc/blacklist/tmp
#  dig +time=2 +tries=1 @ $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 $dom +short >> /etc/blacklist/tmp
  dig +time=2 +tries=1 @8.8.8.8 $dom +short >> /etc/blacklist/tmp
  done

cat  /etc/blacklist/tmp | sort |uniq >  /etc/blacklist/listip.txt


echo -n "Applying blacklist to IPSET..."
ipset -N blacklist iphash
xfile=$(cat /etc/blacklist/listip.txt)
for ipaddr in $xfile
do
  ipset -A blacklist $ipaddr
  done
  echo "...Done"
  echo -n "Applying blacklist to Netfilter..."
  iptables -v -I FORWARD -m set --match-set blacklist src -j DROP
  iptables -v -I FORWARD -m set --match-set blacklist src -j LOG --log-prefix "DROP blacklist entry"
  echo "...Done"
  iptables -I FORWARD -s 192.168.0.11 -j ACCEPT
#  iptables -I FORWARD -s 192.168.0.1 -j ACCEPT



  iptables -I FORWARD -d 192.168.0.11 -j ACCEPT
#  iptables -I FORWARD -d 192.168.0.1 -j ACCEPT