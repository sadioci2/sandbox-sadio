# Create an EC2 instance
resource "aws_instance" "my_ec2"{
ami           = data.aws_ami.ubuntu.id
instance_type = var.instance_type
# key_name = var.key_pair
vpc_security_group_ids = [data.aws_security_group.existing_sg.id]

user_data = file("${path.module}/scripts/jenkins_master.sh")

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-ec2", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
    }
  )
}
