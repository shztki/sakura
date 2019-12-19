resource "sakuracloud_internet" "router" {
  name = var.router["name"]

  #ネットワークマスク
  nw_mask_len = var.router["nw_mask_len"]

  #帯域幅(Mbps単位)
  band_width = var.router["band_width"]

  #IPv6有効化
  enable_ipv6 = var.router["enable_ipv6"]

  description = var.router["memo"]
  tags        = [var.my_account, var.my_domain]
}
