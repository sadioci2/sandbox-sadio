
variable "aws_region" {
  type = string
}
variable "session_duration" {
  type = number
}
variable "session_name" {
  type = string
}
variable "principal_arn" {
   type = string
}
variable "common_tags" {
  type = map(string)
}