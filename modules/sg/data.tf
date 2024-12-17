data "aws_vpc" "vpc" {
  filter {
    name   = "is-default"
    values = ["false"]
  }

  filter {
    name   = "tag:environment"
    values = ["dev"]
  }
}