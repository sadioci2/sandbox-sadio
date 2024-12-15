resource "aws_instance" "bastion" {
  depends_on = [aws_instance.private_instance]
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.public.id
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  user_data = data.template_file.bastion_script.rendered
  
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-%s", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"],
    "public-ec2")
  })
}

resource "aws_instance" "private_instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.private.id
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.private_instance_sg.id]
  user_data =  file("${path.module}/scripts/voguepay.sh")

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-%s", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"],
    "private-ec2")
  })
}

