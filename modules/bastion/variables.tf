variable "bastion_ip" {
  description = "IP address for the Bastion host"
  type        = string
}

variable "ssh_key_path" {
  description = "Path to the SSH key for Bastion host"
  type        = string
}

variable "ssh_key_name" {
  description = "The name of the SSH key"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}