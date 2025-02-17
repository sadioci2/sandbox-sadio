resource "aws_secretsmanager_secret" "destination_secrets" {
  for_each    = data.aws_secretsmanager_secret.source_secrets
  provider    = aws.destination
  name        = each.value.name
  description = each.value.description
  kms_key_id  = each.value.kms_key_id
}

resource "aws_secretsmanager_secret_version" "destination_secret_versions" {
  for_each      = data.aws_secretsmanager_secret_version.source_secret_versions
  provider      = aws.destination
  secret_id     = aws_secretsmanager_secret.destination_secrets[each.key].id
  secret_string = each.value.secret_string
}
