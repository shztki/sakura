resource "sakuracloud_disk" "disk" {
  count             = var.server["count"]
  name              = format("%s%03d", var.disk["name"], count.index + 1)
  source_archive_id = data.sakuracloud_archive.ubuntu1804.id
  plan              = var.disk["plan"]
  connector         = var.disk["connector"]
  size              = var.disk["size"]
  tags              = [var.my_account, var.my_domain]
  description       = format("%s%03d", var.disk["memo"], count.index + 1)
}

resource "sakuracloud_disk" "disk02" {
  zone              = var.second_zone
  count             = var.server02["count"]
  name              = format("%s%03d", var.disk02["name"], count.index + 1)
  source_archive_id = data.sakuracloud_archive.centos7.id
  plan              = var.disk02["plan"]
  connector         = var.disk02["connector"]
  size              = var.disk02["size"]
  tags              = [var.my_account, var.my_domain]
  description       = format("%s%03d", var.disk02["memo"], count.index + 1)
}

resource "sakuracloud_disk" "vpc_disk" {
  count             = var.vpc_server["count"]
  name              = format("%s%03d", var.vpc_disk["name"], count.index + 1)
  source_archive_id = data.sakuracloud_archive.centos7_vpc.id
  plan              = var.vpc_disk["plan"]
  connector         = var.vpc_disk["connector"]
  size              = var.vpc_disk["size"]
  tags              = [var.my_account, var.my_domain]
  description       = format("%s%03d", var.vpc_disk["memo"], count.index + 1)
}