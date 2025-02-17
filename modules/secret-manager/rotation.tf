# resource "aws_secretsmanager_secret" "secrets" {
#   for_each                = toset(var.secret_names)
#   recovery_window_in_days = 0
#   name                    = each.key

#   tags = merge(var.common_tags, {
#     Name = each.key
#   })

#   # Enable rotation based on the secret name
#   dynamic "rotation_rules" {
#     for_each = local.should_rotate[each.key] ? [1] : []

#     content {
#       automatically_after_days = local.rotation_days[each.key]
#     }
#   }

#   # Assign rotation Lambda ARN based on the secret name
#   rotation_lambda_arn = local.rotation_lambda_arns[each.key]
# }

# # Local mappings for conditional rotation
# locals {
#   should_rotate = {
#     db_password = true
#     key_pair    = true
#     default     = false
#   }

#   rotation_days = {
#     db_password = var.db_password_rotation_days
#     key_pair    = var.key_pair_rotation_days
#     default     = null
#   }

#   rotation_lambda_arns = {
#     db_password = var.db_password_rotation_lambda
#     key_pair    = var.key_pair_rotation_lambda
#     default     = null
#   }
# }
