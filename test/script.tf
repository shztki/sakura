resource "sakuracloud_note" "init_note" {
  count   = var.server["count"]
  name    = format("%s_%s_%d", module.label.id, var.init_script["name"], count.index + 10)
  class   = var.init_script["class"]
  content = file(format("userdata/ubuntu1804_%d.sh", count.index + 10))
  tags    = module.label.attributes
}

resource "sakuracloud_note" "init_note02" {
  count   = var.server02["count"]
  name    = format("%s_%s_%d", module.label.id, var.init_script02["name"], count.index + 100)
  class   = var.init_script02["class"]
  content = file(format("userdata/centos7_%d.sh", count.index + 100))
  tags    = module.label.attributes
}

resource "sakuracloud_note" "init_note03" {
  count   = var.vpc_server["count"]
  name    = format("%s_%s_%d", module.label.id, var.init_script03["name"], count.index + 10)
  class   = var.init_script03["class"]
  content = file(format("userdata/centos7_vpc_%d.sh", count.index + 10))
  tags    = module.label.attributes
}
