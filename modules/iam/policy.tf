# resource "aws_iam_group_policy_attachment" "policy_attachments" {
#   for_each = {
#     for group, policies in var.dept_policies :
#     "${group}" => flatten([
#       for idx, policy in policies :
#       {
#         group      = group
#         policy_arn = policy
#       }
#     ])
#   }

#   group      = aws_iam_group.department[each.value[0].group].name
#   policy_arn = each.value[0].policy_arn
# }


resource "aws_iam_group_policy" "group_policies" {
  for_each = var.dept_policies

  name   = "${each.key}-department-policy"
  group  = aws_iam_group.department[each.key].name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      for policy_arn in each.value : {
        Effect   = "Allow"
        Action   = "*"
        Resource = policy_arn
      }
    ]
  })
}
