resource "aws_launch_template" "jenkins_lt" {
  name          = "jenkins-launch-template"
#   image_id      = data.aws_ami.ubuntu.id
  image_id      =  "ami-0bdc8b7108f6d10c1"
  instance_type = var.instance_type
  key_name      = var.key_pair
#   user_data     = base64encode(file("${path.module}/scripts/jenkins_master.sh"))

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = var.volume_size
      volume_type = var.volume_type
      delete_on_termination = true
    }
  }

  network_interfaces {
    # security_groups = [aws_security_group.jenkins_sg.id]
    security_groups = [data.aws_security_group.sg.id]
    subnet_id       = element(var.private_subnets, 0)
     associate_public_ip_address = false
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.common_tags,{
      Name = format("%s-%s-%s-jenkins_sg", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
    })
  }
}