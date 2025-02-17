resource "aws_db_instance" "blueops" {
  identifier        = var.db_id
  instance_class    = var.db_instance
  allocated_storage = var.db_storage
  engine            = var.db_type
  engine_version    = var.db_version
  db_name           = var.db_name
  username = jsondecode(data.aws_secretsmanager_secret_version.db_username.secret_string).db_username
  password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string).db_password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  parameter_group_name   = aws_db_parameter_group.blueops.name
  publicly_accessible    = var.db_access
  skip_final_snapshot    = var.db_snapshot

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-db", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
  })
}




