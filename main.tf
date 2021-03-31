provider "aws" {
  # profile = "default"
  region = var.region
}

## Another Workspaces ##
# Workspace - vpc
data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "terraexam"
    workspaces = {
      name = "terraexam-aws-vpc"
    }
  }
}

# Workspace - security group
data "terraform_remote_state" "sg" {
  backend = "remote"
  config = {
    organization = "terraexam"
    workspaces = {
      name = "terraexam-aws-sg"
    }
  }
}

locals {
  nick = "${var.name}-oracle"

  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr_block        = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
  public_subnet_ids     = data.terraform_remote_state.vpc.outputs.public_subnets
  private_subnet_ids    = data.terraform_remote_state.vpc.outputs.private_subnets
  database_subnet_ids   = data.terraform_remote_state.vpc.outputs.database_subnets
  database_subnet_group = data.terraform_remote_state.vpc.outputs.database_subnet_group

  bastion_security_group_ids = [data.terraform_remote_state.sg.outputs.bastion_security_group_id]
  alb_security_group_ids     = [data.terraform_remote_state.sg.outputs.alb_security_group_id]
  was_security_group_ids     = [data.terraform_remote_state.sg.outputs.was_security_group_id]
  db_security_group_ids      = [data.terraform_remote_state.sg.outputs.db_security_group_id]
}

#####
# DB
#####
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "2.34.0"

  identifier = local.nick

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine         = var.rds_engine
  engine_version = var.rds_engine_version
  license_model  = var.rds_license_model

  instance_class        = var.rds_instance_class
  storage_type          = var.rds_storage_type
  allocated_storage     = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage
  storage_encrypted     = var.rds_storage_encrypted

  # kms_key_id        = "arm:aws:kms:<region>:<account id>:key/<kms key id>"
  name                                = var.rds_db_name
  username                            = var.rds_username
  password                            = var.rds_password
  port                                = var.rds_port
  iam_database_authentication_enabled = var.rds_iam_database_authentication_enabled
  vpc_security_group_ids              = local.db_security_group_ids
  availability_zone                   = "${var.region}a"
  maintenance_window                  = var.rds_maintenance_window
  backup_window                       = var.rds_backup_window
  multi_az                            = var.rds_multi_az

  # disable backups to create DB faster
  backup_retention_period = var.rds_backup_retention_period

  tags = var.tags

  # alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)
  enabled_cloudwatch_logs_exports = var.rds_enabled_cloudwatch_logs_exports

  # DB subnet group
  # db_subnet_group_name = local.database_subnet_group
  create_db_subnet_group = true
  subnet_ids             = local.database_subnet_ids

  # DB parameter group
  family = var.rds_param_family

  # DB option group
  major_engine_version = var.rds_option_major_engine_version

  # Snapshot name upon DB deletion
  # final_snapshot_identifier = join("", [var.name, "-last-", formatdate("YYYYMMMDDhhmmss", timestamp())])
  skip_final_snapshot = var.rds_skip_final_snapshot

  # See here for support character sets https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.OracleCharacterSets.html
  character_set_name = var.rds_character_set_name

  # Database Deletion Protection
  deletion_protection = var.rds_deletion_protection

}