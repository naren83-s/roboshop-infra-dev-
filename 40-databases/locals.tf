locals {
  ami_id = data.aws_ami.joindevops.id
  common_tags = {
    Project = var.project
    Environment = var.environment
    Terraform = true
  }
  database_subnet_id = split(",", data.aws_ssm_parameter.database_subnet_ids.value)[0]
  mongod_sg_id = data.aws_ssm_parameter.mongod_sg_id.value
  redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
  mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
  mysql_role_name = join( "-", [
    for name in ["${var.var.project}","${var.var.environment}","mysql"] : title(name)
  ])
}