locals {
  aliases_ip = slice(sakuracloud_internet.router.ipaddresses, 3, length(sakuracloud_internet.router.ipaddresses))
}

resource "sakuracloud_vpc_router" "foobar" {
  name        = var.vpc_router["name"]
  description = var.vpc_router["memo"]
  tags        = [var.my_account, var.my_domain]
  plan        = var.vpc_router["plan"]

  internet_connection = true

  switch_id  = sakuracloud_internet.router.switch_id
  vip        = sakuracloud_internet.router.ipaddresses[0]
  ipaddress1 = sakuracloud_internet.router.ipaddresses[1]
  ipaddress2 = sakuracloud_internet.router.ipaddresses[2]
  aliases    = local.aliases_ip
  vrid       = var.vpc_router["vrid"]

  # プライベートNICの定義(複数定義可能)
  interface {
    switch_id   = sakuracloud_switch.vpc_switch01.id
    vip         = "192.168.202.1"
    ipaddress   = ["192.168.202.2", "192.168.202.3"]
    nw_mask_len = 24
  }

  # ポートフォワード
  #  port_forwarding {
  #    protocol        = "udp"
  #    global_port     = 10022
  #    private_address = "192.168.11.11"
  #    private_port    = 22
  #    description     = "desc"
  #  }

  # スタティックNAT(プレミアム/ハイスペックプランのみ)
  dynamic "static_nat" {
    for_each = local.aliases_ip
    content {
      global_address  = local.aliases_ip[static_nat.key]
      private_address = format("192.168.202.%d", static_nat.key + 10)
      description     = format("vpc_nat_%03d", static_nat.key + 10)
    }
  }

  # ファイアウォール
  firewall {
    vpc_router_interface_index = 1

    direction = "send"
    expressions {
      protocol    = "tcp"
      source_nw   = ""
      source_port = ""
      dest_nw     = "192.168.202.10"
      dest_port   = "80"
      allow       = true
      logging     = true
      description = "desc"
    }
    expressions {
      protocol    = "tcp"
      source_nw   = ""
      source_port = ""
      dest_nw     = "192.168.202.11"
      dest_port   = "80"
      allow       = true
      logging     = true
      description = "desc"
    }

    expressions {
      protocol    = "ip"
      source_nw   = "192.168.202.0/24"
      source_port = ""
      dest_nw     = ""
      dest_port   = ""
      allow       = true
      logging     = false
      description = "desc"
    }

    expressions {
      protocol    = "ip"
      source_nw   = ""
      source_port = ""
      dest_nw     = ""
      dest_port   = ""
      allow       = false
      logging     = true
      description = "desc"
    }
  }

  # DHCPサーバ
  dhcp_server {
    vpc_router_interface_index = 1

    range_start = "192.168.202.10"
    range_stop  = "192.168.202.99"
    #dns_servers = sakuracloud_server.server[0].dns_servers
  }

  # DHCP スタティックマッピング
  #  dhcp_static_mapping {
  #    ipaddress  = "192.168.202.10"
  #    macaddress = "aa:bb:cc:aa:bb:cc"
  #  }

  # L2TP/IPsec
  l2tp {
    pre_shared_secret = "example"
    range_start       = "192.168.202.200"
    range_stop        = "192.168.202.209"
  }

  # PPTP
  #  pptp {
  #    range_start = "192.168.11.31"
  #    range_stop  = "192.168.11.40"
  #  }

  # リモートアクセスユーザー
  user {
    name     = "testuser"
    password = var.def_pass
  }

  # サイト間VPN 
  #  site_to_site_vpn {
  #    peer              = "8.8.8.8"
  #    remote_id         = "8.8.8.8"
  #    pre_shared_secret = "example"
  #    routes            = ["10.0.0.0/8"]
  #    local_prefix      = ["192.168.21.0/24"]
  #  }

  # スタティックルート
  #  static_route {
  #    prefix   = "172.16.0.0/16"
  #    next_hop = "192.168.11.99"
  #  }
}
