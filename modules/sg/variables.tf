variable "ingress_ports" {
  description = "List of ingress ports to allow"
  type        = list(number)
}

variable "aws_region" {
  type = string
}

variable "ip" {
  type    = list(string)
}
variable "specific_ip" {
  type    = list(string)
}
variable "protocol_type" {
  type = string
}

variable "common_tags" {
  type = map(string)
}