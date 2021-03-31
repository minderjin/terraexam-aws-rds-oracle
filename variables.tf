variable "name" {}
variable "region" {}
variable "tags" {}

variable "rds_engine" {}
variable "rds_engine_version" {}
variable "rds_license_model" {}
variable "rds_instance_class" {}
variable "rds_storage_type" {}
variable "rds_allocated_storage" {}
variable "rds_max_allocated_storage" {}
variable "rds_storage_encrypted" {}
# kms_key_id        = "arm:aws:kms:<region>:<account id>:key/<kms key id>"
variable "rds_db_name" {}
variable "rds_username" {}
variable "rds_password" {}
variable "rds_port" {}
variable "rds_iam_database_authentication_enabled" {}
variable "rds_maintenance_window" {}
variable "rds_backup_window" {}
variable "rds_multi_az" {}
variable "rds_backup_retention_period" {}
variable "rds_enabled_cloudwatch_logs_exports" {}
variable "rds_param_family" {}
variable "rds_option_major_engine_version" {}
variable "rds_skip_final_snapshot" {}
variable "rds_character_set_name" {}
variable "rds_deletion_protection" {}
