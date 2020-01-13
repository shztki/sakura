resource "sakuracloud_proxylb" "elb" {
  name           = module.label.id
  plan           = var.elb["plan"]
  vip_failover   = var.elb["vip_failover"]
  sticky_session = var.elb["sticky_session"]
  timeout        = var.elb["timeout"]
  description    = var.elb["memo"]
  tags           = module.label.attributes

  health_check {
    protocol = "http"
    path     = "/"
    #host_header = "example.com"
    delay_loop = 10
  }

  bind_ports {
    proxy_mode        = "http"
    port              = 80
    redirect_to_https = true
  }
  bind_ports {
    proxy_mode    = "https"
    port          = 443
    support_http2 = true
    #response_header {
    #  header = "Cache-Control"
    #  value  = "public, max-age=10"
    #}
  }

  #sorry_server {
  #  ipaddress = var.sorry_server_ip
  #  port      = 80
  #}

  dynamic "servers" {
    for_each = sakuracloud_server.vpc_server
    content {
      ipaddress = local.aliases_ip[servers.key]
      port      = 80
    }
  }
}

resource "sakuracloud_proxylb_acme" "cert" {
  proxylb_id       = sakuracloud_proxylb.elb.id
  accept_tos       = true
  common_name      = format("elb.%s", var.my_domain)
  update_delay_sec = 120
}
