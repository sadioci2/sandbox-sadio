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
#     key            = "IAM/terraform.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "dev-blueops-jurist-tf-state-lock"
#     encrypt        = true
#   }
# }

locals {
  aws_region = "us-east-2"
  dept =  jsondecode(file("${path.module}/../../../modules/iam/scripts/users.json"))
  dept_policies =  {  
  Devops = [
    "arn:aws:iam::494597675232:policy/DevOpsSecretsPolicy"
    ]
  Engineering = [
     "arn:aws:iam::494597675232:policy/EngineeringSecretsPolicy"
    ]
    Corporate = [
      "arn:aws:iam::aws:policy/AdministratorAccess"
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
