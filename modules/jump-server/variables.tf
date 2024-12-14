variable "aws_region" {
  type    = string
}
variable "instance_type" {
  type    = string
}
variable "bastion" {
  type    = number
}
variable "key_pair" {
  type    = string
}
variable "common_tags" {
  type = map(any)
}
