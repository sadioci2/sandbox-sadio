resource "aws_acm_certificate" "acm_certificate" {
  domain_name               = var.domain_name
  subject_alternative_names = [var.wildcard_domain]
  validation_method         = "DNS"
  tags                      = var.common_tags
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id         = data.aws_route53_zone.route53_zone.zone_id
    name            = each.value.name
  records         = [each.value.record]
  ttl             = var.ttl
  type            = each.value.type
  allow_overwrite = true
  
}

resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.acm_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]
}
