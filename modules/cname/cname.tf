resource "aws_instance" "demo-instance"{
  ami             = "ami-0d7ae6a161c5c4239"
  instance_type   = "t2.micro"
  subnet_id       = "subnet-00d462ac31a53945b"
  security_groups = [data.aws_security_group.sg.id]
  key_name        = "jurist"
  tags = var.common_tags
}
resource "aws_lb_target_group_attachment" "target_attachment" {
  target_group_arn = data.aws_lb_target_group.target_group.arn
  target_id        = aws_instance.demo-instance.id
  port             = 80
}

resource "aws_route53_record" "cname_record" {
  zone_id = var.zone_id
  name    = var.subdomain
  type    = var.record_type
  ttl     = var.ttl 

  records = [data.aws_lb.alb.dns_name]

}
