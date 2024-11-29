resource "aws_db_parameter_group" "postgres16_param_group" {
  name        = "custom-postgres16"
  family      = "postgres16"
  description = "Custom parameter group for PostgreSQL 16.4"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "16.4"
  instance_class       = "db.t3.micro" # Free tier
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = aws_db_parameter_group.postgres16_param_group.name
  publicly_accessible  = false
  port                 = var.db_port
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "RDS-Instance"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "allow-rds-access"
  description = "Allow access to RDS from bastion host"

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
