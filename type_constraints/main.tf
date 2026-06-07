# EC2 Instance - Demonstrating all type constraints

resource "aws_instance" "web_server" {
  # String type: AMI ID and instance type
  ami = "ami-0ff8a91507f77f867"
  instance_type = var.instance_type
  # Number type: Instance count
  count = var.instance_count
  
  # Bool type: Enable monitoring and public IP
  monitoring = var.enable_monitoring
  associate_public_ip_address = var.associate_public_ip
  
  # Set type: Availability zone (using first element from set)
  availability_zone = tolist(var.availability_zone)[0]

  # List type: Security group
  vpc_security_group_ids = [  ]

  # Object type: Using server config object attributes
  # Note: This demonstrates object access syntax
  # instance_type could also be: var.server_config.instance_type
  # monitoring could also be: var.server_config.monitoring

  # Map type: Tags
  tags = var.instance_tags

  # Root block device using number type
  root_block_device {
    volume_size = var.storage_size
    volume_type = "gp3"
  }
}


resource "aws_security_group" "web_sg" {
  name = "${var.server_config.name}-sg"
  description = "Security group for web server"

  # HTTP access using tuple type (port number from network_config[2])
  ingress {
    from_port = var.network_config[2]
    to_port = var.network_config[2]
    protocol = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  # SSH access  
  ingress {
    from_port = 22
    to_port  = 22
    protocol = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }
  
  # Outbound traffic
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.instance_tags
}