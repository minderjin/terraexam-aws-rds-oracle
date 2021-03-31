###############################################################################################################################################################################
# Terraform loads variables in the following order, with later sources taking precedence over earlier ones:
# 
# Environment variables
# The terraform.tfvars file, if present.
# The terraform.tfvars.json file, if present.
# Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
# Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)
###############################################################################################################################################################################
#
# terraform cloud 와 별도로 동작
# terraform cloud 의 variables 와 동등 레벨
#
# Usage :
#
#   terraform apply -var-file=terraform.tfvars
#
#
# [Terraform Cloud] Environment Variables
#
#     AWS_ACCESS_KEY_ID
#     AWS_SECRET_ACCESS_KEY
#

region = "us-west-2"
name   = "example"
tags = {
  Terraform   = "true"
  Environment = "dev"
}

rds_engine         = "oracle-se2"
rds_engine_version = "19.0.0.0.ru-2021-01.rur-2021-01.r1"
rds_license_model  = "license-included"

rds_instance_class        = "db.t3.small"
rds_storage_type          = "gp2"
rds_allocated_storage     = 20
rds_max_allocated_storage = 100
rds_storage_encrypted     = false

# kms_key_id        = "arm:aws:kms:<region>:<account id>:key/<kms key id>"
rds_db_name                                = "mydb"
rds_username                            = "admin"
rds_password                            = "YourPwdShouldBeLongAndSecure!"
rds_port                                = "1521"
rds_iam_database_authentication_enabled = false
rds_maintenance_window = "Sat:19:00-Sat:21:00"
rds_backup_window      = "16:00-19:00"
rds_multi_az = false

# disable backups to create DB faster
rds_backup_retention_period = 7

# alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)
rds_enabled_cloudwatch_logs_exports = ["alert", "audit", "listener", "trace"]

# DB parameter group
rds_param_family = "oracle-se2-19"

# DB option group
rds_option_major_engine_version = "19"

# Final snapshot
rds_skip_final_snapshot = true

# See here for support character sets https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.OracleCharacterSets.html
rds_character_set_name = "AL32UTF8"

# Database Deletion Protection
rds_deletion_protection = false
