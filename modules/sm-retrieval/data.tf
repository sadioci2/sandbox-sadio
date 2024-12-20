data "aws_secretsmanager_secret" "source_secrets" {
  for_each = toset(var.secret_names)
  provider = aws.source
  name     = each.key
}

data "aws_secretsmanager_secret_version" "source_secret_versions" {
  for_each   = data.aws_secretsmanager_secret.source_secrets
  provider   = aws.source
  secret_id  = each.value.id
}

