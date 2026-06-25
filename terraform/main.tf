terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Security Group for EC2
resource "aws_security_group" "fundme_ec2_sg" {
  name        = "${var.project_name}-ec2-sg"
  description = "Security group for FundMe EC2"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name = "${var.project_name}-ec2-sg"
  }
}

# Security Group for RDS
resource "aws_security_group" "fundme_rds_sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Security group for FundMe RDS"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.fundme_ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

# RDS MySQL Instance
resource "aws_db_instance" "fundme_db" {
  identifier           = "${var.project_name}-db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  db_name              = "fundme_db"
  username             = "admin"
  password             = var.db_password
  publicly_accessible  = true
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.fundme_rds_sg.id]

  tags = {
    Name = "${var.project_name}-db"
  }
}

# EC2 Instance
resource "aws_instance" "fundme_server" {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.fundme_ec2_sg.id]

  tags = {
    Name = "${var.project_name}-server"
  }
}