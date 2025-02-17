variable "aws_region_source" {
  type = string
}
variable "aws_region_destination" {
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