output "server_ip" {
  value = sakuracloud_server.server.*.ipaddress
}

output "dr_server_ip" {
  value = sakuracloud_server.server02.*.ipaddress
}

output "dns_servers" {
  value = sakuracloud_dns.dns.dns_servers
}

output "router_ipaddresses" {
  value = sakuracloud_internet.router.ipaddresses
}

#output "vpc_server_ip" {
#  value = sakuracloud_server.vpc_server.*.ipaddress
#}

output "elb_fqdn" {
  value = sakuracloud_proxylb.elb.fqdn
}

output "elb_networks" {
  value = sakuracloud_proxylb.elb.proxy_networks
}