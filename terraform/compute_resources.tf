# Bastion Host
resource "aws_instance" "bastion" {
  ami           = "ami-03d1b2fa19c17c9f1"
  instance_type = "t2.micro"

  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.bastion_sg.id]
  key_name      = "my-key-pair-terraform" 

  associate_public_ip_address = true

  tags = {
    Name = "Bastion-Host"
  }
}

# Безпекова група для Bastion Host
resource "aws_security_group" "bastion_sg" {
  vpc_id = module.vpc.vpc_id

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

  tags = {
    Name = "Bastion-Security-Group"
  }
}


# Приватний EC2 інстанс
resource "aws_instance" "private_instance" {
  ami           = "ami-03d1b2fa19c17c9f1"
  instance_type = "t2.micro"

  # Параметр user_data для автоматичного запуску скрипта при створенні інстансу
  user_data = <<-EOF
              #!/bin/bash
              cd /home/ec2-user
              curl -O https://my-docker-installation-scripts.s3.us-east-1.amazonaws.com/install_docker.sh
              chmod +x install_docker.sh
              ./install_docker.sh
              EOF

  subnet_id       = module.vpc.private_subnets[0]
  security_groups = [aws_security_group.private_instance_sg.id]
  key_name      = "my-key-pair-terraform"

  tags = {
    Name = "Private-Instance"
  }
}

# Security Group для приватних EC2 інстансів
resource "aws_security_group" "private_instance_sg" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  # Дозволяє HTTP трафік від Load Balancer
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.lb_sg.id]  # Security Group Load Balancer
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private-Instance-Security-Group"
  }
}

# Прив'язка EC2 інстансу до Target Group
resource "aws_lb_target_group_attachment" "app_tg_attachment" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.private_instance.id
  port             = 80
}
