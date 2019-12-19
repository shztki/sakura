resource "sakuracloud_server" "server" {
  count             = var.server["count"]
  name              = format("%s%03d", var.server["name"], count.index + 1)
  disks             = [element(sakuracloud_disk.disk.*.id, count.index)]
  core              = var.server["core"]
  memory            = var.server["memory"]
  interface_driver  = var.server["interface_driver"]
  packet_filter_ids = [sakuracloud_packet_filter.myfilter.id]
  description       = format("%s%03d", var.server["memo"], count.index + 1)
  tags              = ["@auto-reboot", var.my_account, format("%s%03d", var.server["name"], count.index + 1), var.my_domain]
  hostname          = format("%s%03d.%s", var.server["name"], count.index + 1, var.my_domain)
  ssh_key_ids       = [sakuracloud_ssh_key.mykey.id]
  password          = var.def_pass
  disable_pw_auth   = true

  note_ids                       = [element(sakuracloud_note.init_note.*.id, count.index)]
  additional_nics                = [sakuracloud_switch.switch01.id]
  additional_display_ipaddresses = [format("192.168.201.%d", count.index + 10)]
}

resource "sakuracloud_server" "server02" {
  zone              = var.second_zone
  count             = var.server02["count"]
  name              = format("%s%03d", var.server02["name"], count.index + 1)
  disks             = [element(sakuracloud_disk.disk02.*.id, count.index)]
  core              = var.server02["core"]
  memory            = var.server02["memory"]
  interface_driver  = var.server02["interface_driver"]
  packet_filter_ids = [sakuracloud_packet_filter.myfilter02.id]
  description       = format("%s%03d", var.server02["memo"], count.index + 1)
  tags              = ["@auto-reboot", var.my_account, format("%s%03d", var.server02["name"], count.index + 1), var.my_domain]
  hostname          = format("%s%03d.%s", var.server02["name"], count.index + 1, var.my_domain)
  ssh_key_ids       = [sakuracloud_ssh_key.mykey.id]
  password          = var.def_pass
  disable_pw_auth   = true

  note_ids                       = [element(sakuracloud_note.init_note02.*.id, count.index)]
  additional_nics                = [sakuracloud_switch.switch02.id]
  additional_display_ipaddresses = [format("192.168.201.%d", count.index + 100)]
}

resource "sakuracloud_server" "vpc_server" {
  count            = var.vpc_server["count"]
  name             = format("%s%03d", var.vpc_server["name"], count.index + 1)
  disks            = [element(sakuracloud_disk.vpc_disk.*.id, count.index)]
  core             = var.vpc_server["core"]
  memory           = var.vpc_server["memory"]
  interface_driver = var.vpc_server["interface_driver"]
  nic              = sakuracloud_switch.vpc_switch01.id
  #display_ipaddress = format("192.168.202.%d", count.index + 10)
  #ipaddress         = format("192.168.202.%d", count.index + 10)
  #gateway           = "192.168.202.1"
  #nw_mask_len       = "24"
  #packet_filter_ids = [sakuracloud_packet_filter.myfilter.id]
  description     = format("%s%03d", var.vpc_server["memo"], count.index + 1)
  tags            = ["@auto-reboot", var.group_tag[count.index % 2], var.my_account, format("%s%03d", var.vpc_server["name"], count.index + 1), var.my_domain]
  hostname        = format("%s%03d.%s", var.vpc_server["name"], count.index + 1, var.my_domain)
  ssh_key_ids     = [sakuracloud_ssh_key.mykey.id]
  password        = var.def_pass
  disable_pw_auth = true

  note_ids = [element(sakuracloud_note.init_note03.*.id, count.index)]
  #additional_nics                = [sakuracloud_switch.vpc_switch01.id]
  #additional_display_ipaddresses = [format("192.168.202.%d", count.index + 10)]
}

