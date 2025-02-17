resource "aws_secretsmanager_secret" "secrets" {
  for_each                = toset(var.secret_names)
  recovery_window_in_days = var.recovery
  name                    = each.key
  description = "Api key for ${each.key}"
  
  tags = merge(var.common_tags, {
    Name = each.key
  })
}

# resource "aws_secretsmanager_secret_rotation" "rotation" {
#   for_each = { for name in var.secret_names : name => name if name == "db_password" }
#   secret_id           = aws_secretsmanager_secret.secrets[each.key].id
#   rotation_lambda_arn = var.default_rotation
#   rotation_rules {
#     automatically_after_days = var.rotation_rule
#   }
# }

# resource "aws_lambda_function" "my_lambda" {
#   function_name = format("%s-%s-%s-mysql-password", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
#   role          = aws_iam_role.secrets_manager_role.arn 
# tags = merge(var.common_tags, {
# Name = format("%s-%s-%s-mysql-password", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
# })
# }


