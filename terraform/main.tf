module "rds" {
  source      = "../modules/rds"
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  db_host     = var.db_host
  db_port     = var.db_port
}

module "redis" {
  source     = "../modules/redis"
  redis_name = var.redis_name
}

module "bastion" {
  source       = "../modules/bastion"
  bastion_ip   = var.bastion_ip
  ssh_key_path = var.ssh_key_path
  ssh_key_name = var.ssh_key_name
  subnet_id    = var.subnet_id
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "redis_endpoint" {
  value = module.redis.redis_endpoint
}

output "bastion_host" {
  value = module.bastion.bastion_ip
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
}

variable "db_host" {
  description = "The host for the database"
  type        = string
}

variable "db_port" {
  description = "The port for the database"
  type        = number
}

variable "ssh_key_name" {
  description = "The name of the SSH key to access the bastion instance"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID for the bastion instance"
  type        = string
}