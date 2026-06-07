variable "environment" {
  type = string
  description = "The environment Type"
  default = "dev"
}


variable "region" {
  type = string
  description = "The AWS region"
  default = "us-east-1"
}


variable "instance_type" {
  type = string
  description = "The EC2 instance type"
  default = "t2.micro"
}


variable "instance_count" {
  type = number
  description = "The number of ec2 instances to create"
  default = 1
}


variable "storage_size" {
  type = number
  description = "The storage size for ec2 instance in GB"
  default = 8
}


variable "enable_monitoring" {
  type = bool
  description = "Enable detailed monitoring for ec2 instances"
  default = false
}


variable "associate_public_ip" {
  type = bool
  description = "associate public ip to ec2 instance"
  default = false
}


variable "allowed_cidr_blocks" {
  type = list(string)
  description = "List of allowed cidr blocks for security group"
  default = [ "10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16" ]
}


variable "allowed_instance_type" {
  type = list(string)
  description = "List of allowed ec2 instance types"
  default = [ "t2.micro", "t2.small", "t3.micro" ]
}


variable "instance_tags" {
  type = map(string)
  description = "tags to apply to the ec2 instances"
  default = {
    "Environment" = "dev"
    "Project" = "terraform-project"
    "Owner" = "devops-team"
  }
}


variable "availability_zone" {
  type = set(string)
  description = "set of availability zones (no duplicates)"
  default = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
}


variable "network_config" {
  type = tuple([ string, string, number ])
  description = "Network configuration (VPC CIDR, subnet CIDR, port number)"
  default = [ "10.0.0.0/16", "10.0.1.0/24", 80 ]
}


variable "server_config" {
  type = object({
    name = string
    instance_type = string
    monitoring = bool
    storage_gb = number
    backup_enabled = bool
 })
  description = "Complete server configuration object"
  default = {
    name = "web-server"
    instance_type = "t2.micro"
    monitoring = true
    storage_gb = 8
    backup_enabled = false
 }
}
