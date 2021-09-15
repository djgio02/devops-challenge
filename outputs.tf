output "vpc_id" {
  value = module.networking.vpc_id
}

output "private_subnet_id_1" {
  value = module.networking.private_subnet_id_1
}

output "private_subnet_id_2" {
  value = module.networking.private_subnet_id_2
}

output "public_subnet_id_1" {
  value = module.networking.pubblic_subnet_id_1
}

output "public_subnet_id_2" {
  value = module.networking.pubblic_subnet_id_2
}
output "db_endpoint" {
  value = module.database.db_endpoint
}