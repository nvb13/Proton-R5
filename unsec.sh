#!/bin/ash

lan_ip="$(ifconfig br-lan | grep "inet addr:" | cut -d ':' -f2 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')"

uci set uhttpd.main.listen_http="$lan_ip:80"
uci set uhttpd.main.listen_https="$lan_ip:443"
uci set uhttpd.main.redirect_https="1"
uci commit uhttpd
service uhttpd start
/etc/init.d/dropbear start
