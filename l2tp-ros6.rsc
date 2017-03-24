# L2tp-IPSec on RouterOS 6.36.4
# By Maspur [0822 3348 3221] gombyok@gmail.com
#
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-256-cbc,3des
/ip pool
add name=pool1 ranges=10.200.200.2-10.200.200.200
/ppp profile
add change-tcp-mss=yes dns-server=8.8.8.8 local-address=10.200.200.1 name=\
    profile-ppp only-one=yes remote-address=pool1 use-encryption=yes
/tool user-manager customer
set admin access=\
    own-routers,own-users,own-profiles,own-limits,config-payment-gw
/interface l2tp-server server
set default-profile=profile-ppp enabled=yes
/ip firewall filter
add chain=input dst-port=1701,500,4500 in-interface=ether1 protocol=udp
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/ip ipsec peer
add address=0.0.0.0/0 exchange-mode=main-l2tp generate-policy=port-override \
    secret=rahasia
