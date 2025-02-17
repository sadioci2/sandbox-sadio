variable "aws_region" {
  type    = string
}

variable "instance_type" {
  type    = string
}
variable "volume_size" {
  type    = number
}
variable "desired_capacity" {
  type    = number
}
variable "min_size" {
  type    = number
}
variable "max_size" {
  type    = number
}
variable "health_check_grace_period" {
  type    = number
}
variable "cooldown" {
  type    = number
}
variable "scaling_adjustment" {
  type    = number
}
variable "scale_down_adjustment" {
  type    = number
}
variable "adjustment_type" {
  type    = string
}
variable "health_check_type" {
  type    = string
}
variable "volume_type" {
  type    = string
}
variable "record_ttl" {
  type = number
}
variable "record_type" {
  type = string
}
variable "key_pair" {
  type    = string
}
variable "ip" {
  type    = list(string)
}
variable "protocol_type" {
  type    = string
}
variable "ingress_ports" {
  type        = list(number)
}
variable "common_tags" {
  type = map(any)
}

variable "domain_name" {
  type        = string
}
variable "vpc_id" {
type = string
}

variable "public_subnets" {
type = list(string)
}

variable "private_subnets" {
type = list(string)
}