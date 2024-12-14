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

# data "template_file" "public_data" {
#     template= templatefile("${path.module}/scripts/connection.sh", {
#     BASTION_IP = aws_instance.servers[0].public_ip
#     PRIVATE_IP = aws_instance.servers[1].private_ip
#     SSH_KEY_PATH = "~/Downloads/jurist.pem"
#   })
# }

# data "template_file" "private_data" {
#   template = file("${path.module}/scripts/privateec2.sh")

#   vars = {
#     BASTION_IP   = aws_instance.servers[0].public_ip
#     PRIVATE_IP   = aws_instance.servers[1].private_ip
#     SSH_KEY_NAME = "authorized_keys"
#     SSH_KEY_PATH = "/home/ubuntu/.ssh/authorized_keys"
#   }
# }
data "aws_secretsmanager_secret" "key" {
  name = "key-pair"
}

data "aws_secretsmanager_secret_version" "key" {
  secret_id = data.aws_secretsmanager_secret.key.id
}