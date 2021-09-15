
module "networking" {
    source        = "./networking"
    vpc_cidr      = "192.168.0.0/16"
    public_cidrs  = ["192.168.20.0/24", "192.168.40.0/24"]
    private_cidrs = ["192.168.10.0/24", "192.168.30.0/24"]
}

module "database" {
    source      = "./database"
    db_name     = "postgres"
    db_username = "postgres"
    db_password = "postgres"
    db_subnet_group_name = module.networking.db_subnet_group
    vpc_security_group_ids = module.networking.db_sg 
}