provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

# Get the current account ID
data "aws_caller_identity" "current" {}

# Fetch Subnets
data "aws_subnet_ids" "main" {
  vpc_id = var.vpc_id
}

# KMS Module for Key Management
module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "~> 1.0"

  description             = "KMS key for Aurora MySQL encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 10

  key_users = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/test-user"]
}

# RDS Subnet Group Module
module "rds_subnet_group" {
  source  = "terraform-aws-modules/rds/aws//modules/db-subnet-group"
  version = "~> 5.0"

  name       = "aurora-subnet-group"
  subnet_ids = data.aws_subnet_ids.main.ids # Use appropriate subnets
}

# Security Group for Aurora
module "aurora_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "aurora-sg"
  description = "Security group for Aurora MySQL"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # Replace with your IP range for testing
    },
  ]
}

# Aurora RDS Module
module "aurora_mysql" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 7.0"

  name           = "aurora-test-cluster"
  engine         = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.10.2"
  instance_class = "db.t3.medium" # Smallest instance class for testing
  vpc_id         = var.vpc_id
  subnets        = data.aws_subnet_ids.main.ids

  storage_encrypted = true
  kms_key_id        = module.kms.key_arn

  db_subnet_group_name   = module.rds_subnet_group.db_subnet_group_name
  vpc_security_group_ids = [module.aurora_security_group.security_group_id]

  # For testing, use lower backup retention and replicas
  backup_retention_period = 1
  preferred_backup_window = "07:00-09:00"
  apply_immediately       = true

  # replica_count = 1

  master_username = var.master_username
  master_password = var.master_password
  database_name   = var.database_name
}
