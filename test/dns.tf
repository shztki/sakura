# DNSゾーン登録
resource "sakuracloud_dns" "dns" {
  zone        = var.my_domain
  description = var.domain["memo"]
  tags        = [var.my_account, var.my_domain]
}

resource "sakuracloud_dns_record" "record_server" {
  dns_id = sakuracloud_dns.dns.id
  count  = var.server["count"]
  name   = element(sakuracloud_server.server.*.name, count.index)
  type   = "A"
  ttl    = 300
  value  = element(sakuracloud_server.server.*.ipaddress, count.index)
}

resource "sakuracloud_dns_record" "record_server02" {
  dns_id = sakuracloud_dns.dns.id
  count  = var.server02["count"]
  name   = element(sakuracloud_server.server02.*.name, count.index)
  type   = "A"
  ttl    = 300
  value  = element(sakuracloud_server.server02.*.ipaddress, count.index)
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
  type   = "CNAME"
  ttl    = 300
  value  = format("%s.", sakuracloud_proxylb.foobar.fqdn)
}