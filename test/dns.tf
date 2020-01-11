# DNSゾーン登録
resource "sakuracloud_dns" "dns" {
  zone        = var.my_domain
  description = var.domain["memo"]
  tags        = module.label.attributes
}

resource "sakuracloud_dns_record" "record_server" {
  dns_id = sakuracloud_dns.dns.id
  count  = var.server["count"]
  #name   = element(sakuracloud_server.server.*.name, count.index)
  name  = format("%s%03d", var.server["name"], count.index + 1)
  type  = "A"
  ttl   = 300
  value = element(sakuracloud_server.server.*.ipaddress, count.index)
}

resource "sakuracloud_dns_record" "record_server02" {
  dns_id = sakuracloud_dns.dns.id
  count  = var.server02["count"]
  #name   = element(sakuracloud_server.server02.*.name, count.index)
  name  = format("%s%03d", var.server02["name"], count.index + 1)
  type  = "A"
  ttl   = 300
  value = element(sakuracloud_server.server02.*.ipaddress, count.index)
}

resource "sakuracloud_dns_record" "record_gslb" {
  dns_id = sakuracloud_dns.dns.id
  name   = "@"
  type   = "ALIAS"
  ttl    = 300
  value  = format("%s.", sakuracloud_gslb.gslb.fqdn)
}

resource "sakuracloud_dns_record" "record_elb" {
  dns_id = sakuracloud_dns.dns.id
  name   = "elb"
  type   = "ALIAS"
  ttl    = 300
  value  = format("%s.", sakuracloud_proxylb.elb.fqdn)
}
