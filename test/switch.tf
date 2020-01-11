resource "sakuracloud_switch" "switch01" {
  name        = format("%s-%s", module.label.id, var.switch01["name"])
  description = var.switch01["memo"]
  tags        = module.label.attributes
  bridge_id   = sakuracloud_bridge.bridge.id
}

resource "sakuracloud_switch" "switch02" {
  zone        = var.second_zone
  name        = format("%s-%s", module.label.id, var.switch02["name"])
  description = var.switch02["memo"]
  tags        = module.label.attributes
  bridge_id   = sakuracloud_bridge.bridge.id
}

resource "sakuracloud_bridge" "bridge" {
  name        = format("%s-%s", module.label.id, var.bridge["name"])
  description = var.bridge["memo"]
}

resource "sakuracloud_switch" "vpc_switch01" {
  name        = format("%s-%s", module.label.id, var.vpc_switch01["name"])
  description = var.vpc_switch01["memo"]
  tags        = module.label.attributes
  #bridge_id   = sakuracloud_bridge.bridge.id
}

