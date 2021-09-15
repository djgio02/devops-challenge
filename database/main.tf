# --- database/main.tf ---


resource "aws_db_instance" "postgresdb" {
    allocated_storage    = 10
    engine               = "postgres"
    engine_version       = "13.2"
    instance_class       = "db.t3.medium"
    storage_type         = "gp2"
    max_allocated_storage =  30
    identifier           = var.db_name 
    username             = var.db_username
    password             = var.db_password
    skip_final_snapshot  = true
    db_subnet_group_name = var.db_subnet_group_name
    multi_az             = true
    vpc_security_group_ids = var.vpc_security_group_ids
    auto_minor_version_upgrade = false 
    backup_retention_period = 14
}
