#!/bin/bash
# @sacloud-once

function init_network() {
  nmcli con mod "System eth0" \
  ipv4.method auto \
  connection.autoconnect "yes" \
  ipv6.method ignore
  nmcli con down "System eth0"; nmcli con up "System eth0"
}
#init_network

function init_httpd() {
  systemctl list-unit-files | grep -q "httpd" && return 0;
  yum install -y httpd mod_ssl
  systemctl enable httpd
  systemctl start httpd
  echo "vpctest10" > /var/www/html/index.html
}
init_httpd

function init_firewalld() {
  systemctl stop firewalld
  systemctl disable firewalld
}
init_firewalld