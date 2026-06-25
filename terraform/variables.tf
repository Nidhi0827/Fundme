variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "db_password" {
  description = "RDS database password"
  sensitive   = true
  default     = "Admin1234!"
}

variable "project_name" {
  description = "Project name"
  default     = "fundme"
}