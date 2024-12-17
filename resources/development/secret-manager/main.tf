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
#     key            = "secret-manager/terraform.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "dev-blueops-jurist-tf-state-lock"
#     encrypt        = true
#   }
# }

locals {
aws_region = "us-east-2"
secret_names = ["db_username","db_password", "key_pair"]
rotation_rule = 90
default_rotation ="arn:aws:lambda:us-east-2:713881795316:function:aws-secretsmanager-rds-mysql-rotation"
recovery = 0
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

module "secret-manager" {
source             = "../../../modules/secret-manager"
aws_region   = local.aws_region
secret_names = local.secret_names
recovery = local.recovery
rotation_rule = local.rotation_rule
default_rotation = local.default_rotation
common_tags        = local.common_tags
}
