# L2TP-IPSec-on-Mikrotik
# ini adalah script untuk mengaktifkan server vpn L2tp-ipsec di Mikrotik RouterOS
# This is a script to run the vpn service using L2TP with ipsec in the MikroTik RouterOS
# 1st howto: downlaod this rsc file 
https://github.com/maspurmikrotiker/L2TP-IPSec-on-Mikrotik/blob/master/l2tp-ipsec.rsc
> upload to your mikrotik ftp server (click Files menu from winbox and drag (l2tp-ipsec.rsc) from your downloads folder )
#
> click New Terminal and type: 
#
import l2tp-ipsec.rsc
#
> done!!! your vpn server is activated

#2nd howto: simply copy-paste this code below into terminal
> start from here
#
/ip pool
add name=pool1 ranges=10.100.0.2-10.100.0.200

/ppp profile
add change-tcp-mss=yes dns-server=8.8.8.8 local-address=10.100.0.1 name=\
    vpn-us only-one=yes remote-address=pool1 use-ipv6=default

/ip ipsec peer
add exchange-mode=main-l2tp generate-policy=yes hash-algorithm=sha1 \
    nat-traversal=yes secret=rahasia

/ip ipsec proposal
set [ find default=yes ] enc-algorithms=3des,aes-256

/ip firewall filter
add chain=input dst-port=1701,500,4500 in-interface=ether1 protocol=udp

/interface l2tp-server server
set default-profile=vpn-us enabled=yes

> done!!! your vpn server is activated
