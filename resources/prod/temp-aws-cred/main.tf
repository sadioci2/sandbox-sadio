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
#     key            = "temp-aws-cred/terraform.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "dev-blueops-jurist-tf-state-lock"
#     encrypt        = true
#   }
# }

locals {
aws_region = "us-east-2"
principal_arn = "arn:aws:iam::713881795316:user/IT"
session_duration = 7200
session_name = "terraform_session"
common_tags = {
    "id"             = "2024"
    "owner"          = "jurist"
    "environment"    = "prod"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company"        = "DEL"
  }
}

module "iam" {
  source        = "../../../modules/temp-aws-cred"
  aws_region    = local.aws_region      
  principal_arn  = local.principal_arn       
  session_duration = local.session_duration
  session_name = local.session_name
  common_tags   = local.common_tags    
}
