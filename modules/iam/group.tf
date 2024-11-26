resource "aws_iam_group" "department" {
  for_each = toset(values(var.dept))
  name     = each.key
}

resource "aws_iam_group_membership" "department" {
   depends_on = [aws_iam_user.users]
  for_each = aws_iam_group.department
  name     = "${each.key}-department"
  group    = each.value.name
  users    = [for user, group in var.dept : user if group == each.key]
}

