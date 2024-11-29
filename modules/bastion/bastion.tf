# Використовуємо автоматичне отримання ID VPC
data "aws_vpc" "selected_vpc" {
  default = true  # Автоматично вибирає дефолтний VPC, якщо він є
}

# Змінна для CIDR блоку підмережі
variable "subnet_cidr_block" {
  description = "CIDR block for the subnet of the bastion host"
  type        = string
  default     = "10.0.1.0/24"  # Задайте CIDR для вашої публічної підмережі
}

# Отримуємо список підмереж для вказаного VPC та CIDR блоку
data "aws_subnets" "all_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected_vpc.id]  # Використовуємо отриманий VPC ID
  }

  filter {
    name   = "cidrBlock"
    values = [var.subnet_cidr_block]  # Фільтруємо за CIDR блоком (наприклад, "10.0.1.0/24")
  }
}

# Виведення для перевірки ID VPC
output "vpc_id" {
  value = data.aws_vpc.selected_vpc.id
}

# Виведення для перевірки підмереж
output "subnet_ids" {
  value = data.aws_subnets.all_subnets.ids
}

# Ресурс для Bastion instance
resource "aws_instance" "bastion" {
  ami                         = "ami-003542581452a9bf8"
  instance_type               = "t2.micro"
  key_name                    = var.ssh_key_name
  subnet_id                   = "subnet-01558e339dc0de686"
  associate_public_ip_address = true

  tags = {
    Name = "Bastion"
  }
}

# Безпекова група для Bastion
resource "aws_security_group" "bastion_sg" {
  name_prefix = "bastion_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
