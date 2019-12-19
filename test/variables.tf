variable "default_zone" {
  default = "tk1a"
}
variable "second_zone" {
  default = "is1a"
}

variable "def_pass" {}
variable "my_domain" {}
variable "sorry_server_ip" {}
variable "my_account" {}

variable "group_tag" {
  default = ["@group=a", "@group=b"]
}

variable "ssh_pubkey_path" {}
variable "sshkey" {
  default = {
    name = "example001"
    memo = "example001"
  }
}

variable "filter" {
  default = {
    name = "example"
    memo = "example"
  }
}
variable "protocol" {
  default = ["tcp", "udp", "udp", "icmp", "tcp", "tcp", "tcp", "tcp", "tcp", "udp", "fragment", "ip"]
}
variable "source_nw" {
  default = ["", "", "", "", "", "", "", "", "", "", "", ""]
}
variable "source_port" {
  default = ["", "53", "123", "", "", "80", "", "443", "32768-65535", "32768-65535", "", ""]
}
variable "dest_port" {
  default = ["22", "", "", "", "80", "", "443", "", "", "", "", ""]
}
variable "allow" {
  default = [true, true, true, true, true, true, true, true, true, true, true, false]
}


variable "disk" {
  default = {
    name      = "example"
    size      = 20
    plan      = "ssd"    # ssd or hdd
    connector = "virtio" # virtio or ide
    memo      = "example"
  }
}

variable "disk02" {
  default = {
    name      = "dr"
    size      = 20
    plan      = "ssd"    # ssd or hdd
    connector = "virtio" # virtio or ide
    memo      = "dr"
  }
}

variable "vpc_disk" {
  default = {
    name      = "vpc"
    size      = 20
    plan      = "ssd"    # ssd or hdd
    connector = "virtio" # virtio or ide
    memo      = "vpc"
  }
}

variable "server" {
  default = {
    count            = 1
    core             = 1
    memory           = 1
    commitment       = "standard"
    interface_driver = "virtio"
    name             = "example"
    memo             = "example"
  }
}

variable "server02" {
  default = {
    count            = 1
    core             = 1
    memory           = 1
    commitment       = "standard"
    interface_driver = "virtio"
    name             = "dr"
    memo             = "dr"
  }
}

variable "vpc_server" {
  default = {
    count            = 2
    core             = 1
    memory           = 1
    commitment       = "standard"
    interface_driver = "virtio"
    name             = "vpc"
    memo             = "vpc"
  }
}

variable "domain" {
  default = {
    memo = "example"
  }
}

variable "gslb" {
  default = {
    name = "example"
    memo = "example"
  }
}

variable "switch01" {
  default = {
    name = "192.168.201.0/24"
    memo = "example"
  }
}

variable "switch02" {
  default = {
    name = "192.168.201.0/24_dr"
    memo = "dr"
  }
}

variable "bridge" {
  default = {
    name = "192.168.201.0/24_br"
    memo = "example_br"
  }
}

variable "vpc_switch01" {
  default = {
    name = "192.168.202.0/24"
    memo = "example"
  }
}

variable "init_script" {
  default = {
    name  = "init_ubuntu1804_example"
    class = "shell" # shell or yaml_cloud_config
  }
}

variable "init_script02" {
  default = {
    name  = "init_centos7_example"
    class = "shell" # shell or yaml_cloud_config
  }
}

variable "init_script03" {
  default = {
    name  = "init_centos7_vpc"
    class = "shell" # shell or yaml_cloud_config
  }
}

variable "router" {
  default = {
    name        = "example"
    nw_mask_len = 28
    band_width  = 100
    enable_ipv6 = false
    memo        = "example"
  }
}

variable "vpc_router" {
  default = {
    name = "example_vpc"
    memo = "example_vpc"
    plan = "premium"
    vrid = 1
  }
}

variable "elb" {
  default = {
    name           = "example"
    memo           = "example"
    plan           = 100
    vip_failover   = true
    sticky_session = false
    timeout        = 600
  }
}