data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# data "aws_security_group" "existing_sg" {
# name = "jurist-group"
# }
# data "aws_route53_zone" "route53_zone" {
#   name         = var.domain_name
#   private_zone = false
# }
# Data source to get security group by tags
# data "aws_security_group" "alb_sg" {
#   filter {
#     name   = "tag:Name"
#     values = ["dev-jurist-blueops-albsg"]
#   }

#   filter {
#     name   = "tag:environment"
#     values = ["dev"]
#   }
# }

# Data source to get ALB Target Group by name
data "aws_lb_target_group" "jenkins_target_group" {
  name = "jenkins-tg"
}

# Data source to get ALB by name
data "aws_lb" "alb" {
  name = "dev-jurist-blueops-alb" 
}