provider sakuracloud {
  zone = var.default_zone
  version = "<2.0.0"
}

module "label" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=master"
  namespace   = var.label["namespace"]
  stage       = var.label["stage"]
  name        = var.label["name"]
  attributes  = [var.label["namespace"], var.label["stage"], var.label["name"]]
  delimiter   = "-"
  label_order = ["namespace", "stage", "name"]
}

terraform {
  required_version = ">= 0.12.14"
  backend "remote" {}
}
