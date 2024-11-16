module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"  # Основний діапазон адрес

  # Задаємо публічні і приватні підмережі для різних AZ
  azs             = ["us-east-1a", "us-east-1b"]  # Зони доступності для публічних і приватних підмереж
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"] # Підмережі для публічних ресурсів (ALB, Bastion Host)
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"] # Підмережі для приватних ресурсів (EC2, RDS)

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = true
  
  enable_dns_hostnames = true # Включаємо DNS для EC2

  tags = {
    Name = "my-vpc"
  }
}



