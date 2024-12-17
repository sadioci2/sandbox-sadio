variable "aws_region" {
  type = string
}
variable "secret_names" {
type = list(string)
}

variable "rotation_rule" {
  type = number
}
variable "recovery" {
  type = number
}
variable "default_rotation" {
  type = string
}
variable "common_tags" {
  type = map(any)
}