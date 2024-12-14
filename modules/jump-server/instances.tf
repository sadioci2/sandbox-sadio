resource "aws_instance" "servers" {
  count                  = var.bastion
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = count.index == 0 ? aws_subnet.public.id : aws_subnet.private.id
  key_name               = var.key_pair
  vpc_security_group_ids = count.index == 0 ? [aws_security_group.bastion_sg.id] : [aws_security_group.private_instance_sg.id]

user_data = count.index == 0 ? templatefile("${path.module}/scripts/bastion.sh", {
  private_key = base64decode(jsondecode(data.aws_secretsmanager_secret_version.key.secret_string).key)
}) : file("${path.module}/scripts/voguepay.sh")

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-%s", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"],
    count.index == 0 ? "public-ec2" : "private-ec2")
  })
}


