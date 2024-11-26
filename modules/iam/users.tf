resource "aws_iam_user" "users" {
  for_each = var.dept
  name     = each.key

  tags = merge(var.common_tags, {
    Name = format("%s-%s", var.common_tags["company"], each.value)
  })
}
