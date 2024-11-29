variable "redis_name" {
  description = "Name of the Redis instance"
  type        = string
}

variable "bastion_ip" {
  description = "IP address for the Bastion host"
  type        = string
}

variable "ssh_key_path" {
  description = "Path to the SSH key for Bastion host"
  type        = string
}
