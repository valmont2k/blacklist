"# blacklist" 


simple internet blocker based on linux firewall iptables and ipset

a)install on linux gate :

0) apt-get update ; apt-get install ipset iptables ... etc

1) copy files to /etc/blacklist

2) # chmod +x /etc/blacklist/block.sh

3) write /etc/blacklist/block.sh to end of your /etc/init.d/firewall

4) restart your firewall (simple way by "/etc/init.d/firewall restart")

5) done

b) use :

1) modify /etc/blacklist/listdomains.txt(add domain one domain to one string)

2) restart your firewall

c) how it works

1) dig your domains from /etc/blacklist/listdomains.txt, collect ip to /etc/blacklist/listip.txt, block it, add whitelist local ip in block.sh(today it 192.168.0.11 use own)

