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
#     bucket         = "dev-jurist-demo-project-tf-state"
#     key            = "acm/terraform.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "dev-jurist-demo-project-tf-state-lock"
#     encrypt        = true
#   }
# }

locals {
  aws_region      = "us-east-2"
  domain_name     = "thejurist.org.uk"
  wildcard_domain = "*.thejurist.org.uk"
  ttl             = 60
  common_tags = {
    "id"             = "2024"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company"        = "DEL"
  }
}

module "acm" {
  source          = "../../../modules/acm"
  aws_region      = local.aws_region
  domain_name     = local.domain_name
  wildcard_domain = local.wildcard_domain
  ttl             = 60
  common_tags     = local.common_tags
}