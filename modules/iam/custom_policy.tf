resource "aws_iam_policy" "devops_secrets_policy" {
  name        = "DevOpsSecretsPolicy"
  description = "Policy providing full access to Secrets Manager in Ohio and read-only access in North Virginia."
  policy      = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Sid       = "FullAccessInOhio",
        Effect    = "Allow",
        Action    = [
          "secretsmanager:*"
        ],
        Resource  = "*",
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = "us-east-2"
          }
        }
      },
      {
        Sid       = "ReadOnlyInNorthVirginia",
        Effect    = "Allow",
        Action    = [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue",
          "secretsmanager:ListSecrets",
          "secretsmanager:ListSecretVersionIds"
        ],
        Resource  = "*",
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = "us-east-1"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "engineering_secrets_policy" {
  name        = "EngineeringSecretsPolicy"
  description = "Policy denying access to Secrets Manager in Ohio and allowing read-only access in North Virginia."
  policy      = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Sid       = "DenyAllInOhio",
        Effect    = "Deny",
        Action    = "secretsmanager:*",
        Resource  = "*",
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = "us-east-2"
          }
        }
      },
      {
        Sid       = "ReadOnlyInNorthVirginia",
        Effect    = "Allow",
        Action    = [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue",
          "secretsmanager:ListSecrets",
          "secretsmanager:ListSecretVersionIds"
        ],
        Resource  = "*",
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = "us-east-1"
          }
        }
      }
    ]
  })
}


