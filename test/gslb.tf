resource "sakuracloud_gslb" "gslb" {
  name = var.gslb["name"]

  health_check {
    protocol   = "http"
    delay_loop = 10
    #host_header = "example.com"
    path   = "/"
    status = "200"
    #port   = 80
  }

  weighted     = true
  sorry_server = var.sorry_server_ip
  description  = var.gslb["memo"]
  tags         = [var.my_account, var.my_domain]
}

resource "sakuracloud_gslb_server" "gslb_server01" {
  gslb_id   = sakuracloud_gslb.gslb.id
  count     = var.server["count"]
  ipaddress = element(sakuracloud_server.server.*.ipaddress, count.index)
  weight    = 1
  enabled   = true
}

resource "sakuracloud_gslb_server" "gslb_server02" {
  gslb_id   = sakuracloud_gslb.gslb.id
  count     = var.server02["count"]
  ipaddress = element(sakuracloud_server.server02.*.ipaddress, count.index)
  weight    = 1
  enabled   = true
}
