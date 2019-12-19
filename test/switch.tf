resource "sakuracloud_switch" "switch01" {
  name        = var.switch01["name"]
  description = var.switch01["memo"]
  tags        = [var.my_account, var.my_domain]
  bridge_id   = sakuracloud_bridge.bridge.id
}

resource "sakuracloud_switch" "switch02" {
  zone        = var.second_zone
  name        = var.switch02["name"]
  description = var.switch02["memo"]
  tags        = [var.my_account, var.my_domain]
  bridge_id   = sakuracloud_bridge.bridge.id
}

resource "sakuracloud_bridge" "bridge" {
  name        = var.bridge["name"]
  description = var.bridge["memo"]
}

resource "sakuracloud_switch" "vpc_switch01" {
  name        = var.vpc_switch01["name"]
  description = var.vpc_switch01["memo"]
  tags        = [var.my_account, var.my_domain]
  #bridge_id   = sakuracloud_bridge.bridge.id
}

