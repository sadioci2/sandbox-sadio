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

provider "aws" {
  region = local.aws_region
}

locals {
aws_region              = "us-east-2"
cluster_name            = "dev-jurist-blueops-control-plane"
eks_version             = 1.31
endpoint_private_access = false
endpoint_public_access  = true
common_tags = {
    "id"             = "2024"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company"        = "DEL"
  }
eks_subnet_ids = {
    us-east-2a = "subnet-0ebbd1751fb00c957"
    us-east-2b = "subnet-0ffe054defef01d13"
    us-east-2c = "subnet-0306d57d9ddb7b080"
  }
}
module "EKS" {
  source                  = "../../modules/EKS-control-plane"
  aws_region              = local.aws_region
  common_tags             = local.common_tags
  cluster_name            = local.cluster_name
  eks_version             = local.eks_version
  eks_subnet_ids          = local.eks_subnet_ids
  endpoint_private_access = local.endpoint_private_access
  endpoint_public_access  = local.endpoint_public_access
}