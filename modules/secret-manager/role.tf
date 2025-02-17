# resource "aws_iam_role" "secrets_manager_role" {
#   name     = format("%s-%s-%s-secret-manager-role", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect    = "Allow"
#         Principal = {
#           Service = "secretsmanager.amazonaws.com"
#         }
#         Action    = "sts:AssumeRole"
#       }
#     ]
#   })
#     tags = merge(var.common_tags, {
#     Name = format("%s-%s-%s-secret-manager-role", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
#   })
# }

# resource "aws_iam_policy" "lambda_invocation_policy" {
#   name     = format("%s-%s-%s-lambda-policy", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect   = "Allow"
#         Action   = "lambda:InvokeFunction"
#         Resource = "arn:aws:lambda:us-east-2:713881795316:function:aws-secretsmanager-rds-mysql-rotation"
#       }
#     ]
#   })
#   tags = merge(var.common_tags, {
#     Name = format("%s-%s-%s-lambda-policy", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
#   })
# }
# resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
#   role       = aws_iam_role.secrets_manager_role.name
#   policy_arn = aws_iam_policy.lambda_invocation_policy.arn
  
# }

# resource "aws_lambda_permission" "allow_secrets_manager" {
#   statement_id  = "AllowSecretsManagerInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = var.default_rotation 
#   principal     = "secretsmanager.amazonaws.com"
# }