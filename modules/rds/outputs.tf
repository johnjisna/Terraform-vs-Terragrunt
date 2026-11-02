output "db_endpoint" {
  value = module.db.db_instance_endpoint
}

output "db_secret_arn" {
  description = "Secrets Manager ARN holding the master password"
  value       = module.db.db_instance_master_user_secret_arn
}

output "security_group_id" {
  value = aws_security_group.this.id
}
