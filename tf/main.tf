provider "aws" {
  region = "us-east-1"
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  security_group_id = data.aws_security_group.default.id

  cidr_ipv4   = "${chomp(data.http.myip.response_body)}/32"
  from_port   = 3306
  ip_protocol = "tcp"
  to_port     = 3306
}


module "mysql_cluster" {
  source = "terraform-aws-modules/rds-aurora/aws"

  name           = "test-aurora-db-mysql"
  engine         = "aurora-mysql"
  engine_version = "8.0"
  instance_class = "db.t3.medium"
  instances = {
    one = { publicly_accessible = true }
  }

  create_db_subnet_group = true
  create_security_group  = false
  create_monitoring_role = false

  manage_master_user_password = false
  master_username             = var.master_username
  master_password             = var.master_password
  database_name               = var.database_name

  subnets                = data.aws_subnets.default.ids
  vpc_security_group_ids = [data.aws_security_group.default.id]

  storage_encrypted   = true
  apply_immediately   = true
  skip_final_snapshot = true

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
