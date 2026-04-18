data "dns_a_record_set" "example" {
  host = "google.com"
}

output "google_ipv4" {
  value = chomp(data.dns_a_record_set.example.addrs[0])
}

data "aws_ssm_parameter" "bastion_sg_id" {
    name = "/${var.project}/${var.environment}/bastion_sg_id"
}

data "aws_ssm_parameter" "mongod_sg_id" {
    name = "/${var.project}/${var.environment}/mongod_sg_id"
}

data "aws_ssm_parameter" "catalogue_sg_id" {
    name = "/${var.project}/${var.environment}/catalogue_sg_id"
}

data "aws_ssm_parameter" "user_sg_id" {
    name = "/${var.project}/${var.environment}/user_sg_id"
}

data "aws_ssm_parameter" "redis_sg_id" {
    name = "/${var.project}/${var.environment}/redis_sg_id"
}

data "aws_ssm_parameter" "mysql_sg_id" {
    name = "/${var.project}/${var.environment}/mysql_sg_id"
}