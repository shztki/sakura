resource "sakuracloud_internet" "router" {
  name = module.label.id

  #ネットワークマスク
  nw_mask_len = var.router["nw_mask_len"]

  #帯域幅(Mbps単位)
  band_width = var.router["band_width"]

  #IPv6有効化
  enable_ipv6 = var.router["enable_ipv6"]

  description = var.router["memo"]
  tags        = module.label.attributes
}

# after router create
# ルータ＋スイッチの、スイッチ側のパラメータが変更できないので、あとからインポートして変更したいときに利用
resource "sakuracloud_switch" "router" {
  name        = module.label.id
  tags        = module.label.attributes
  description = var.router["memo"]
}

