
resource "aws_iam_role" "worker_role" {
  name                  = "HR-role"
  max_session_duration  = var.session_duration
  assume_role_policy    = jsonencode({
    Version             = "2012-10-17"
    Statement           = [
      {
        Effect          = "Allow"
        Principal       = {
          AWS           = var.principal_arn
        }
        Action          = "sts:AssumeRole"
      }
    ]
  })
    tags = merge(var.common_tags, {
    Name = "HR-role"
  })
}

resource "aws_iam_policy" "worker_policy" {
  depends_on = [ aws_iam_role.worker_role]
    name        = "HR-policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # {
      #   Effect   = "Allow"
      #   Action   = "sts:AssumeRole"
      #   Resource =  aws_iam_role.worker_role.arn
      # },
        {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      }
    ]
  })
   tags = merge(var.common_tags, {
    Name = "HR-policy"
  })
}

resource "aws_iam_role_policy_attachment" "worker_role_policy_attachment" {
  role       = aws_iam_role.worker_role.name
  policy_arn = aws_iam_policy.worker_policy.arn
}

# resource "null_resource" "assume_role" {
#   depends_on = [ 
#                  aws_iam_role_policy_attachment.worker_role_policy_attachment
#                ]
#   provisioner "local-exec" {
#     command = "sleep 5 & aws sts assume-role --role-arn ${aws_iam_role.worker_role.arn} --role-session-name ${var.session_name}"
#   }
# }
resource "null_resource" "assume_role" {
  depends_on = [
    aws_iam_role_policy_attachment.worker_role_policy_attachment
  ]

  provisioner "local-exec" {
    command = "bash ${path.module}/script.sh ${aws_iam_role.worker_role.arn} ${var.session_name}"
  }
}
