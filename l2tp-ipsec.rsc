# vpn server using L2tp-ipsec on Mikrotik RoutesOS
# for mobile and desktop clients
# by maspur
# layanan jasa setting mikrotik +6282233483221

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
