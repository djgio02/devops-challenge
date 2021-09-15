# --- networking/main.tf ---

data "aws_availability_zones" "available"{}

resource "random_integer" "random" {
    min = 1
    max = 50
}

resource "aws_vpc" "eksctl_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "eksctl_vpc-${random_integer.random.id}"
    }
    lifecycle {
        create_before_destroy = true
    }

}

resource "aws_subnet" "public_subnet" {
    count = length(var.public_cidrs)
    vpc_id = aws_vpc.eksctl_vpc.id
    cidr_block = var.public_cidrs[count.index]
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[count.index]
    
    tags = {
        Name = "public_subnet_${count.index+1}"
    }

}

resource "aws_route_table_association" "publicrt_assoc" {
    count = 2
    subnet_id      = aws_subnet.public_subnet.*.id[count.index] 
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "private_subnet" {
    count = length(var.private_cidrs)
    vpc_id = aws_vpc.eksctl_vpc.id
    cidr_block = var.private_cidrs[count.index]
    map_public_ip_on_launch = false
    availability_zone = data.aws_availability_zones.available.names[count.index]
    
    tags = {
        Name = "private_subnet_${count.index+1}"
    }

}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.eksctl_vpc.id

    tags = {
        Name = "eksctl_igw"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.eksctl_vpc.id

    tags = {
        Name = "eksctl_public_rt"
    }

}

resource "aws_route" "default_route" {
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id

}

resource "aws_default_route_table" "private_rt" {
    default_route_table_id = aws_vpc.eksctl_vpc.default_route_table_id

    tags = {
        Name = "eksctl_private_rt"
    }
}

resource "aws_db_subnet_group" "eksctl_rds_subnetgroup" {
    name = "eksctl_rds_subnetgroup"
    subnet_ids = aws_subnet.private_subnet.*.id 
}

resource "aws_security_group" "db_sg" {
    name = "db_sg"
    description = "sg for db conection"
    vpc_id = aws_vpc.eksctl_vpc.id
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = var.public_cidrs 
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

/* resource "aws_security_group" "public_sg" {
    name = "public sg"
    description = "sg for to navigate"
    vpc_id = aws_vpc.eksctl_vpc.id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = var.public_cidrs
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
} */