variable "aws_region" {
  type    = string
}

variable "db_instance" {
  type    = string
}

variable "db_id" {
  type    = string
}
variable "db_storage" {
  type    = number
}
variable "db_type" {
  type    = string
}
variable "db_version" {
  type    = string
}
variable "db_name" {
  type    = string
}
variable "db_family" {
  type    = string
}
variable "db_access" {
  type    = bool
}
variable "db_snapshot" {
  type    = bool
}
variable "common_tags" {
  type = map(any)
}

variable "db_parameters" {
  type = map(any)
}