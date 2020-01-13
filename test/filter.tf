resource "sakuracloud_packet_filter" "myfilter" {
  name        = module.label.id
  description = var.filter["memo"]

  dynamic "expressions" {
    for_each = var.protocol
    content {
      protocol    = var.protocol[expressions.key]
      source_nw   = var.source_nw[expressions.key]
      source_port = var.source_port[expressions.key]
      dest_port   = var.dest_port[expressions.key]
      allow       = var.allow[expressions.key]
    }
  }
}

resource "sakuracloud_packet_filter" "myfilter02" {
  zone        = var.second_zone
  name        = module.label.id
  description = var.filter["memo"]

  dynamic "expressions" {
    for_each = var.protocol
    content {
      protocol    = var.protocol[expressions.key]
      source_nw   = var.source_nw[expressions.key]
      source_port = var.source_port[expressions.key]
      dest_port   = var.dest_port[expressions.key]
      allow       = var.allow[expressions.key]
    }
  }
}

#resource sakuracloud_packet_filter_rule "rules" {
#  packet_filter_id = sakuracloud_packet_filter.myfilter.id
#  protocol         = var.protocol[count.index]
#  source_nw        = var.source_nw[count.index]
#  source_port      = var.source_port[count.index]
#  dest_port        = var.dest_port[count.index]
#  allow            = var.allow[count.index]
#
#  order = count.index
#  count = length(var.protocol)
#}
