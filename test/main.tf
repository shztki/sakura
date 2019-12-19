provider sakuracloud {
  zone = var.default_zone
}

terraform {
  required_version = ">= 0.12.14"
  backend "remote" {}
}
