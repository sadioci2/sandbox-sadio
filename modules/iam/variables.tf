variable "aws_region" {
  type    = string
}


variable "dept" {
  type = map(any)
}

variable "common_tags" {
  type = map(any)
}

variable "dept_policies" {
  type = map(list(string))
}