variable "aws_region" {
  description = "AWS Region Name"
  type = string
  default = "ap-southeast-1"
}

variable "environment" {
  description = "Environment name (dev or staging or prod)"
  type = string
  default = "dev"
}

variable "vpc_a_cidr" {
  description = "CIDR block for the VPC A"
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_b_cidr" {
  description = "CIDR block for the VPC B"
  type = string
  default = "11.0.0.0/16"
}

variable "vpc_c_cidr" {
  description = "CIDR block for the VPC C"
  type = string
  default = "12.0.0.0/16"
}

variable "default_tags" {
  description = "Default Tags"
  type = map(string)
  default = {
    "Environment" = "Dev"
    "Purpose" = "TransitGateway"
  }
}

variable "vpc_a_public_cidr" {
  description = "CIDR block for the VPC A Public Subnet"
  type = string
  default = "10.0.1.0/24"
}

variable "vpc_b_private_cidr" {
  description = "CIDR block for the VPC B Private Subnet"
  type = string
  default = "11.0.1.0/24"
}

variable "vpc_c_private_cidr" {
  description = "CIDR block for the VPC C Private Subnet"
  type = string
  default = "12.0.1.0/24"
}

variable "subnet_az" {
  description = "Availability Zone for all Subnet"
  type = string
  default = "ap-southeast-1a"
}

variable "transit_gateway_az" {
  description = "Availability Zone for all VPC Transit Gateway"
  type = string
  default = "ap-southeast-1a"
}

variable "vpc_a_transit_gatway_subnet_cidr" {
  description = "CIDR block for the VPC A Transit Gateway"
  type = string
  default = "10.0.2.0/28"
}

variable "vpc_b_transit_gatway_subnet_cidr" {
  description = "CIDR block for the VPC B Transit Gateway"
  type = string
  default = "11.0.2.0/28"
}

variable "vpc_c_transit_gatway_subnet_cidr" {
  description = "CIDR block for the VPC C Transit Gateway"
  type = string
  default = "12.0.2.0/28"
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t2.micro"
}

variable "ec2_key_name" {
  description = "Name of the SSH key pair for VPC instance (ap-southeast-1)"
  type = string
  default = ""
}