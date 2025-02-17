resource "aws_security_group" "sg" {
  name        = format("%s-%s-%s-sg", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
  vpc_id      = data.aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.protocol_type
      cidr_blocks = var.ip
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.ip
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-sg", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
  })
}