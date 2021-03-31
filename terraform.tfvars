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
rds_db_name                             = "ORCL"
rds_username                            = "admin"
rds_password                            = "YourPwdShouldBeLongAndSecure!"
rds_port                                = "1521"
rds_iam_database_authentication_enabled = false
rds_maintenance_window                  = "Sat:19:00-Sat:21:00"
rds_backup_window                       = "16:00-19:00"
rds_multi_az                            = false

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

rds_parameters = []
#  {
#    name  = "audit_trail"
#    value = os | db [, extended] | xml [, extended]
#  }
#]

rds_options = [
   {
     option_name = "Timezone"

     option_settings = [
       {
         name  = "TIME_ZONE"
         value = "Asia/Seoul"
       },
     ]
   },
 ]

# The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60.
rds_monitoring_interval = 60

# Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs.
rds_create_monitoring_role = true

# Name of the IAM role which will be created when create_monitoring_role is enabled.
rds_monitoring_role_name = "rds-monitoring-role-0"


# Specifies whether Performance Insights are enabled
rds_performance_insights_enabled = true

# The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years).
rds_performance_insights_retention_period = 7
