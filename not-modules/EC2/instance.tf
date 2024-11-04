
provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# EC2 Instance
resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-06b21ccaeff8cd686"  # Replace with a valid AMI ID for us-east-1
  instance_type = "t2.micro"               # Modify as per your requirements
  key_name      = "sandbox"
  vpc_security_group_ids = [aws_security_group.allow_all_traffic.id]

  # Tags for the instance
  tags = {
    Name  = "Sandbox-instance"
    Owner = "DEL"
    Year  = "2024"
    ID    = "9090"
  }
}

# Security Group to allow all inbound traffic
resource "aws_security_group" "allow_all_traffic" {
  name_prefix = "allow_all_traffic_"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # Allows all inbound traffic
    cidr_blocks = ["0.0.0.0/0"] # Open to the world; restrict as needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
