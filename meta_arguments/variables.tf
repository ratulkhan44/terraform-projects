# String type
variable "environment" {
  type        = string
  description = "The environment type"
  default     = "dev"
}

variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "us-east-1"
}

# Number type
variable "instance_count" {
  type        = number
  description = "Number of EC2 instances to create"
  default     = 2
}

# Bool type
variable "enable_versioning" {
  type        = bool
  description = "Enable versioning for S3 buckets"
  default     = true
}

# List type
variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "s3_bucket_names" {
  type        = list(string)
  description = "List of S3 bucket names for count example"
  default     = ["tf-count-bucket-a-20260608", "tf-count-bucket-b-20260608"]
}

# Set type - used with for_each
variable "s3_bucket_set" {
  type        = set(string)
  description = "Set of S3 bucket names for for_each example"
  default     = ["tf-foreach-bucket-a-20260608", "tf-foreach-bucket-b-20260608"]
}

# Map type
variable "resource_tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default = {
    "environment" = "dev"
    "managed_by"  = "terraform"
    "department"  = "devops"
  }
}

# Object type
variable "ec2_config" {
  type = object({
    instance_type = string
    ami_id        = string
    volume_size   = number
  })
  description = "EC2 instance configuration"
  default = {
    instance_type = "t2.micro"
    ami_id        = "ami-0ff8a91507f77f867" # Amazon Linux 2 (update for your region)
    volume_size   = 20
  }
}

# Tuple type
variable "network_config" {
  type        = tuple([string, string, number])
  description = "Network configuration (VPC CIDR, Subnet CIDR, subnet count)"
  default     = ["10.0.0.0/16", "10.0.1.0/24", 3]
}