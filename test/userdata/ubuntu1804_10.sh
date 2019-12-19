#!/bin/bash
# @sacloud-once

function init_network() {
  local FILE_NETPLAN="/etc/netplan/01-netcfg.yaml"
  grep -q "eth1" $FILE_NETPLAN && return 0;
  sed -i "3i\    eth1:\n      addresses:\n        - 192.168.201.10/24\n      dhcp4: 'no'\n      dhcp6: 'no'" $FILE_NETPLAN
  netplan apply
}
init_network

function init_httpd() {
  systemctl list-unit-files | grep -q "apache2" && return 0;
  apt install -y apache2
  systemctl enable apache2
  systemctl start apache2
}
init_httpd
