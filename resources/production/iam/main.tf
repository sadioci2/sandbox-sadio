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

terraform {
  backend "s3" {
    bucket         = "dev-blueops-jurist-tf-state"
    key            = "IAM/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "dev-blueops-jurist-tf-state-lock"
    encrypt        = true
  }
}

locals {
  aws_region = "us-east-2"
  dept =  jsondecode(file("${path.module}/../../../modules/iam/scripts/users.json"))
  dept_policies =  {  
  HR = [
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/IAMReadOnlyAccess",
      "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
      "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    ]
    IT = [
      "arn:aws:iam::aws:policy/AdministratorAccess"
    ]
    Corporate = [
      "arn:aws:iam::aws:policy/AdministratorAccess"
    ]
    CEG = [
      "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
      "arn:aws:iam::aws:policy/AdministratorAccess-AWSElasticBeanstalk",
      "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    ]
    Network = [
      "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
      "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/IAMFullAccess"
    ]
  }

  common_tags = {
    "id"             = "2024"
    "owner"          = "jurist"
    "environment"    = "production"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company"        = "DEL"
  }
}

module "iam" {
  source        = "../../../modules/iam"
  aws_region    = local.aws_region      
  dept          = local.dept             
  dept_policies = local.dept_policies   
  common_tags   = local.common_tags    
}
