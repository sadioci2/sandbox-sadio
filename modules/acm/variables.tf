variable "aws_region" {
  type        = string
  }

variable "domain_name" {
  type        = string
}
variable "ttl" {
  type        = number
}
variable "wildcard_domain" {
  type        = string
  }

variable "common_tags" {
  type = map(any)
}