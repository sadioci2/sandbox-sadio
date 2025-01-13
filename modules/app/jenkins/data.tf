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

data "aws_vpc" "main" {
  default = true
}

data "aws_route53_zone" "route53_zone" {
  name         = var.domain_name
  private_zone = false
}

data "aws_security_group" "alb_sg" {
 name = "dev-jurist-blueops-albsg"
}

data "aws_lb_target_group" "jenkins_target_group" {
  name = "jenkins-tg"
}

data "aws_lb" "alb" {
  name = "dev-jurist-blueops-alb" 
}