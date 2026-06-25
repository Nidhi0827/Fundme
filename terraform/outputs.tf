output "ec2_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.fundme_server.public_ip
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.fundme_db.endpoint
}

output "app_url" {
  description = "Application URL"
  value       = "http://${aws_instance.fundme_server.public_ip}:8080"
}