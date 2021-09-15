# --- database/variables.tf ---

variable "db_username" {
    type = string
}

variable "db_name" {
    type = string
}

variable "db_password" {
    type = string
}

variable "vpc_security_group_ids" {
}

variable "db_subnet_group_name" {
  
}