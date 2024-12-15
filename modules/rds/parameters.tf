resource "aws_db_parameter_group" "blueops" {
  name   = var.db_id
  family = var.db_family

  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      name  = parameter.key
      value = parameter.value
    }
  }
}