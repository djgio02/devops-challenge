# --- networking/outputs.tf ---

output "vpc_id" {
    value = aws_vpc.eksctl_vpc.id
}

output "pubblic_subnet_id_1" {
    value = aws_subnet.public_subnet[0].id
}

output "pubblic_subnet_id_2" {
    value = aws_subnet.public_subnet[1].id
}

output "private_subnet_id_1" {
    value = aws_subnet.private_subnet[0].id
}

output "private_subnet_id_2" {
    value = aws_subnet.private_subnet[1].id
}

output "db_sg" {
    value = [aws_security_group.db_sg.id]
}

output "db_subnet_group" {
    value = aws_db_subnet_group.eksctl_rds_subnetgroup.name
}