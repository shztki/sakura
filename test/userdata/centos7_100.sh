#!/bin/bash
# @sacloud-once

function init_network() {
  nmcli con mod "System eth1" \
  ipv4.method manual \
  ipv4.address "192.168.201.100/24" \
  connection.autoconnect "yes" \
  ipv6.method ignore
  nmcli con down "System eth1"; nmcli con up "System eth1"
}
init_network

function init_httpd() {
  systemctl list-unit-files | grep -q "httpd" && return 0;
  yum install -y httpd mod_ssl
  systemctl enable httpd
  systemctl start httpd
  echo "test100" > /var/www/html/index.html
}
init_httpd

function init_masquerade() {
  nmcli c mod "System eth1" connection.zone trusted
  nmcli c mod "System eth0" connection.zone external
  firewall-cmd --zone=trusted --add-masquerade --permanent
  firewall-cmd --add-service=http --zone=external --permanent
  firewall-cmd --reload
  firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -o eth0 -j MASQUERADE
  firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth1 -o eth0 -j ACCEPT
  firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
  iptables-save
}
init_masquerade