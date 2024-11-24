variable "region" {
  type = string
  default = "us-east-2"
}

variable "availability_zones" {
  type = list(string)
  default = ["us-east-2a","us-east-2b","us-east-2c"]
}

variable "cidr_block" {
  type        = string
  description = "VPC cidr block. Example: 10.10.0.0/16"
}

variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "name"             = "blueops-vpc"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company" = "DEL"
  }
}

variable "nat_number" {
  type    = number
  default = 1
}
