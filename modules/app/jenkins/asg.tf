resource "aws_autoscaling_group" "jenkins_asg" {
  launch_template {
    id      = aws_launch_template.jenkins_lt.id
    version = "$Latest"
  }

  vpc_zone_identifier       = var.private_subnets
  desired_capacity          = var.desired_capacity
  min_size                  = var.min_size
  max_size                  = var.max_size
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  target_group_arns = [data.aws_lb_target_group.jenkins_target_group.arn]

  tag {
    key                 = "Name"
    value               = "jenkins"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.jenkins_asg.id
  lb_target_group_arn    = data.aws_lb_target_group.jenkins_target_group.arn
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up-policy"
  scaling_adjustment     = var.scaling_adjustment
  adjustment_type        = var.adjustment_type
  cooldown               = var.cooldown
  autoscaling_group_name = aws_autoscaling_group.jenkins_asg.id
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down-policy"
  scaling_adjustment     = var.scale_down_adjustment
  adjustment_type        = var.adjustment_type
  cooldown               = var.cooldown
  autoscaling_group_name = aws_autoscaling_group.jenkins_asg.id
}