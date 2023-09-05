#!/bin/ash

uci set uhttpd.main.listen_http='127.0.0.1:80'
uci set uhttpd.main.listen_https='127.0.0.1:443'
uci set uhttpd.main.redirect_https="1"
uci commit uhttpd
service uhttpd stop

