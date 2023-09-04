#!/bin/ash

### COM port config
port="/dev/ttyUSB0"
stty -F "$port" -hupcl
stty 9600 -F "$port" raw -echo
###

### Vars
previousValue="0"
# Tun names
Tun1="1US"
Tun2="2DK"
Tun3="3RU"
Tun4="4DE"
Tun5="5NL"
###

### Check TUN num
if [ -z "$tun" ]; then
  echo "N" > "$port"
fi
###

while true; do

### Func test WG
test_wg() {
	port="/dev/ttyUSB0"
	tunnel_status=$(wg show)
	if [ -n "$tunnel_status" ]; then
	  echo "A"
	  echo "A" > "$port"
	  return 1
 	 
	else
	  echo "D"
	  echo "D" > "$port"
	  return 0
	  
	fi
    }
###

### Read Com port
  exec 3<> "$port" 
  read -ru 3 value
  exec 3>&-

### Check button state
#echo $value
if [[ "$value" != "$previousValue" ]]
 then
	#tun=$(echo "$value" | grep -Po "\\d+")
	tun=$(echo "$value" | grep -o '[0-9]*')
#echo "tun=$tun"
################################################################# 1
  if [[ "$tun" == 1 ]]; then
	wireguard_interfaces=$(wg show interfaces)
	if [[ -n "$wireguard_interfaces" ]]; then
     	  ### DOWN WG
   	  #nmcli connection down "$wireguard_interfaces"
   	  ifdown "$Tun1"
   	  ifdown "$Tun2"
   	  ifdown "$Tun3"
   	  ifdown "$Tun4"
   	  ifdown "$Tun5"
    	  #wg-quick down "$wireguard_interfaces"
    	 sleep 1
    	  test_wg
    	 sleep 1
  	fi
  	
  	### WG UP
  	ifup "$Tun1"
  	sleep 1
  	test_wg
################################################################# 1
################################################################# 2
  elif [[ "$tun" == 2 ]]; then
	wireguard_interfaces=$(wg show interfaces)
	if [[ -n "$wireguard_interfaces" ]]; then
     	  ### DOWN WG
   	  #nmcli connection down "$wireguard_interfaces"
   	  ifdown "$Tun1"
   	  ifdown "$Tun2"
   	  ifdown "$Tun3"
   	  ifdown "$Tun4"
   	  ifdown "$Tun5"
    	  #wg-quick down "$wireguard_interfaces"
    	 sleep 1
    	  test_wg
    	 sleep 1
  	fi
  	
  	### WG UP
  	ifup "$Tun2"
  	sleep 1
  	test_wg
################################################################# 2
################################################################# 3
  elif [[ "$tun" == 3 ]]; then
	wireguard_interfaces=$(wg show interfaces)
	if [[ -n "$wireguard_interfaces" ]]; then
     	  ### DOWN WG
   	  #nmcli connection down "$wireguard_interfaces"
   	  ifdown "$Tun1"
   	  ifdown "$Tun2"
   	  ifdown "$Tun3"
   	  ifdown "$Tun4"
   	  ifdown "$Tun5"
    	  #wg-quick down "$wireguard_interfaces"
    	 sleep 1
    	  test_wg
    	 sleep 1
  	fi
  	
  	### WG UP
  	ifup "$Tun3"
  	sleep 1
  	test_wg
################################################################# 3
################################################################# 4
  elif [[ "$tun" == 4 ]]; then
	wireguard_interfaces=$(wg show interfaces)
	if [[ -n "$wireguard_interfaces" ]]; then
     	  ### DOWN WG
   	  #nmcli connection down "$wireguard_interfaces"
   	  ifdown "$Tun1"
   	  ifdown "$Tun2"
   	  ifdown "$Tun3"
   	  ifdown "$Tun4"
   	  ifdown "$Tun5"
    	  #wg-quick down "$wireguard_interfaces"
    	 sleep 1
    	  test_wg
    	 sleep 1
  	fi
  	
  	### WG UP
  	ifup "$Tun4"
  	sleep 1
  	test_wg
################################################################# 4
################################################################# 5
  elif [[ "$tun" == 5 ]]; then
	wireguard_interfaces=$(wg show interfaces)
	if [[ -n "$wireguard_interfaces" ]]; then
     	  ### DOWN WG
   	  #nmcli connection down "$wireguard_interfaces"
   	  ifdown "$Tun1"
   	  ifdown "$Tun2"
   	  ifdown "$Tun3"
   	  ifdown "$Tun4"
   	  ifdown "$Tun5"
    	  #wg-quick down "$wireguard_interfaces"
    	 sleep 1
    	  test_wg
    	 sleep 1
  	fi
  	
  	### WG UP
  	ifup "$Tun5"
  	sleep 1
  	test_wg
################################################################# 5
################################################################# 6
  elif [[ "$tun" == 6 ]]; then
     	  ### DOWN WG
   	  #nmcli connection down "$wireguard_interfaces"
   	  ifdown "$Tun1"
   	  ifdown "$Tun2"
   	  ifdown "$Tun3"
   	  ifdown "$Tun4"
   	  ifdown "$Tun5"
	  uci set network.$Tun1.auto="0"
	  uci set network.$Tun2.auto="0"
	  uci set network.$Tun3.auto="0"
	  uci set network.$Tun4.auto="0"
	  uci set network.$Tun5.auto="0"
	  uci commit network
	  /etc/init.d/network restart
    	  #wg-quick down "$wireguard_interfaces"
    	 sleep 1
    	  test_wg
    	  
################################################################# 6
  fi
previousValue="$value"
fi

  #sleep 0
done
