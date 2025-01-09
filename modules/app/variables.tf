variable "aws_region" {
  type    = string
}

variable "instance_type" {
  type    = string
}

variable "key_pair" {
  type    = string
}
variable "vpc_id" {
  type    = string
}

variable "private-subnets" {
  type    = string
}
variable "common_tags" {
  type = map(any)
}
