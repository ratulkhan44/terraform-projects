# Security Group outputs
output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_sg.id
}


# EC2 Instance outputs
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server[*].id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server[*].public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.web_server[*].private_ip
}


output "instance_type" {
  description = "Instance type of the EC2 instance"
  value       = aws_instance.web_server[*].instance_type
}


# Outputs demonstrating type usage
output "environment_info" {
  description = "Environment information from string type variable"
  value = {
    name         = var.environment
    type         = "string"
    is_staging   = var.environment == "staging"
    display_name = upper(var.environment)
  }
}

output "storage_info" {
  description = "Storage information from number type variable"
  value = {
    disk_size_gb = var.storage_size
    type         = "number"
  }
}

output "instance_configuration" {
  description = "Instance configuration from object type variable"
  value = {
    instance_type = var.server_config.instance_type
    monitoring    = var.server_config.monitoring
    type          = "object"
  }
  sensitive = false
}