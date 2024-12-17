## Terraform block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.44.0"
    }
  }
}

# terraform {
#   backend "s3" {
#     bucket         = "dev-blueops-jurist-tf-state"
#     key            = "SG/terraform.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "dev-blueops-jurist-tf-state-lock"
#     encrypt        = true
#   }
# }

locals {
aws_region = "us-east-2"
ingress_ports= [
  22,
  80,
]
anywhere_ip = [ "0.0.0.0/0" ]
specific_ip = [ "10.10.0.0/16" ]
 protocol_type = "tcp"
common_tags = {
    "id"             = "2024"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company" = "DEL"
  }
}

module "sg" {
  source      = "../../../modules/sg"
  aws_region  = local.aws_region
  ingress_ports = local.ingress_ports
  protocol_type = local.protocol_type
  anywhere_ip = local.anywhere_ip
  specific_ip = local.specific_ip
  common_tags = local.common_tags
  
}