
resource "aws_route53_record" "cname_record" {
  zone_id = var.zone_id
  name    = var.subdomain
  type    = var.record_type
  ttl     = var.ttl 

  records = ["target.${var.domain}"] 

}
