data "sakuracloud_archive" "ubuntu1804" {
  os_type = "ubuntu1804"
}

data "sakuracloud_archive" "centos7" {
  zone    = var.second_zone
  os_type = "centos7"
}

data "sakuracloud_archive" "centos7_vpc" {
  os_type = "centos7"
}
