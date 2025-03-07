aws_region   = "us-east-2"
instance_type = "t2.micro"
key_pair = "jurist"


common_tags = {
    "id"             = "2024"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company" = "DEL"
  }