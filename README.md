Terraform AWS EC2 Module Deployment

This Terraform configuration deploys an EC2 instance on AWS, using a specified module, and assigns custom tags to the resources. The setup includes version requirements for Terraform and the AWS provider.

Prerequisites
Terraform: Version 1.0.0 or newer is required.
AWS Account: Ensure you have an AWS account and appropriate permissions to create EC2 instances.
AWS CLI (optional): For easier configuration of AWS credentials. Install AWS CLI.

Setup and Configuration
AWS Credentials:

Ensure that AWS credentials are configured in your environment. You can do this by running:
aws configure

Alternatively, set environment variables for AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.
Clone the Repository:
Clone or download the module files needed for EC2 in the path specified (../../modules/EC2).

Module Structure:

The EC2 instance configuration resides in a separate module located at ../../modules/EC2.
Ensure this module exists and contains the necessary resources to deploy an EC2 instance.

Variables
This configuration uses locals to set commonly used values

Initialize Terraform:

Run the following command to initialize Terraform and download the necessary provider plugins:
terraform init
Apply Configuration:

Review the resources to be created by running:
terraform plan

To deploy the EC2 instance, apply the configuration:
terraform apply

Confirm the apply step when prompted.

Cleanup:

To delete the resources created by this configuration, run:
terraform destroy

Customization
You can modify the aws_region and common_tags in the locals block to match your environment's requirements.

Script
Use the Script to delete heavy/unwanted terraform files. Ensure to change the directory to suit your need in CleanUp.sh
