resource "aws_route53_record" "jenkins_cname" {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = "jenkins"
  type    = var.record_type
  ttl     = var.record_ttl
  records = [data.aws_lb.alb.dns_name]
}