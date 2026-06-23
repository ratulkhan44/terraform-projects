resource "aws_vpc" "vpc_a" {
  cidr_block = var.vpc_a_cidr

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = merge(
    var.default_tags,
    {
        Name = "VPC-A"
    }
  )
}

resource "aws_vpc" "vpc_b" {
  cidr_block = var.vpc_b_cidr

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = merge(
    var.default_tags,
    {
        Name = "VPC-B"
    }
  )
}

resource "aws_vpc" "vpc_c" {
  cidr_block = var.vpc_c_cidr

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = merge(
    var.default_tags,
    {
        Name = "VPC-C"
    }
  )
}

resource "aws_internet_gateway" "vpc_a_igw" {
  vpc_id = aws_vpc.vpc_a.id
  tags = merge(
    var.default_tags,
    {
        Name = "IGW-VPC-A"
    }
  )
}

resource "aws_subnet" "vpc_a_public_subnet" {
  vpc_id = aws_vpc.vpc_a.id
  cidr_block = var.vpc_a_public_cidr
  availability_zone = var.subnet_az
  map_public_ip_on_launch = true

  tags = merge(
    var.default_tags,
    {
        Name = "VPC-A-Public-Subnet"
    }
  ) 
}

resource "aws_subnet" "vpc_b_private_subnet" {
  vpc_id = aws_vpc.vpc_b.id
  cidr_block = var.vpc_b_private_cidr
  availability_zone = var.subnet_az

  tags = merge(
    var.default_tags,
    {
        Name = "VPC-B-Private-Subnet"
    }
  ) 
}


resource "aws_subnet" "vpc_c_private_subnet" {
  vpc_id = aws_vpc.vpc_c.id
  cidr_block = var.vpc_c_private_cidr
  availability_zone = var.subnet_az

  tags = merge(
    var.default_tags,
    {
        Name = "VPC-C-Private-Subnet"
    }
  ) 
}

resource "aws_subnet" "vpc_a_tgw_subnet" {
  vpc_id = aws_vpc.vpc_a.id
  cidr_block = var.vpc_a_transit_gatway_subnet_cidr
  availability_zone = var.transit_gateway_az

  tags = merge(
    var.default_tags,
    {
        Name = "VPC-A-TransitGateway-Subnet"
    }
  ) 
}

resource "aws_subnet" "vpc_b_tgw_subnet" {
  vpc_id = aws_vpc.vpc_b.id
  cidr_block = var.vpc_b_transit_gatway_subnet_cidr
  availability_zone = var.transit_gateway_az

  tags = merge(
    var.default_tags,
    {
        Name = "VPC-B-TransitGateway-Subnet"
    }
  ) 
}

resource "aws_subnet" "vpc_c_tgw_subnet" {
  vpc_id = aws_vpc.vpc_c.id
  cidr_block = var.vpc_c_transit_gatway_subnet_cidr
  availability_zone = var.transit_gateway_az

  tags = merge(
    var.default_tags,
    {
        Name = "VPC-C-TransitGateway-Subnet"
    }
  ) 
}

resource "aws_route_table" "vpc_a_public_rt" {
  vpc_id = aws_vpc.vpc_a.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_a_igw.id
  }

  tags = {
    Name = "VPC-A-Public-RT"
  }
}

resource "aws_route_table_association" "vpc_a_public_rta" {
  route_table_id = aws_route_table.vpc_a_public_rt.id
  subnet_id = aws_subnet.vpc_a_public_subnet.id
}

resource "aws_route_table" "vpc_b_private_rt" {
  vpc_id = aws_vpc.vpc_b.id

  tags = {
    Name = "VPC-B-Private-RT"
  }
}

resource "aws_route_table_association" "vpc_b_private_rta" {
  route_table_id = aws_route_table.vpc_b_private_rt.id
  subnet_id = aws_subnet.vpc_b_private_subnet.id
}

resource "aws_route_table" "vpc_c_private_rt" {
  vpc_id = aws_vpc.vpc_c.id

  tags = {
    Name = "VPC-C-Private-RT"
  }
}

resource "aws_route_table_association" "vpc_c_private_rta" {
  route_table_id = aws_route_table.vpc_c_private_rt.id
  subnet_id = aws_subnet.vpc_c_private_subnet.id
}

resource "aws_ec2_transit_gateway" "main_tgw" {
  description = "Lab Transit Gateway for VPC connectivity"
  region = var.aws_region
  dns_support = "enable"
  vpn_ecmp_support = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  auto_accept_shared_attachments = "disable"

  tags = {
    Name = "Main-Transit-Gateway"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_a_tgw_attachment" {
  vpc_id = aws_vpc.vpc_a.id
  transit_gateway_id = aws_ec2_transit_gateway.main_tgw.id
  subnet_ids = [aws_subnet.vpc_a_tgw_subnet.id]
  dns_support = "enable"

  tags = {
    Name = "VPC-A-TGW-Attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_b_tgw_attachment" {
  vpc_id = aws_vpc.vpc_b.id
  transit_gateway_id = aws_ec2_transit_gateway.main_tgw.id
  subnet_ids = [aws_subnet.vpc_b_tgw_subnet.id]
  dns_support = "enable"

  tags = {
    Name = "VPC-B-TGW-Attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_c_tgw_attachment" {
  vpc_id = aws_vpc.vpc_c.id
  transit_gateway_id = aws_ec2_transit_gateway.main_tgw.id
  subnet_ids = [aws_subnet.vpc_c_tgw_subnet.id]
  dns_support = "enable"

  tags = {
    Name = "VPC-C-TGW-Attachment"
  }
}

resource "aws_route" "vpc_a_to_b" {
  route_table_id = aws_route_table.vpc_a_public_rt.id
  destination_cidr_block = "11.0.0.0/16"
  transit_gateway_id = aws_ec2_transit_gateway.main_tgw.id
}

resource "aws_route" "vpc_a_to_c" {
  route_table_id = aws_route_table.vpc_a_public_rt.id
  destination_cidr_block = "12.0.0.0/16"
  transit_gateway_id = aws_ec2_transit_gateway.main_tgw.id
}

resource "aws_route" "vpc_b_to_c" {
  route_table_id = aws_route_table.vpc_b_private_rt.id
  destination_cidr_block = "12.0.0.0/16"
  transit_gateway_id = aws_ec2_transit_gateway.main_tgw.id
}

resource "aws_route" "vpc_b_to_a" {
  route_table_id = aws_route_table.vpc_b_private_rt.id
  destination_cidr_block = "10.0.0.0/16"
  transit_gateway_id = aws_ec2_transit_gateway.main_tgw.id
}

resource "aws_route" "vpc_c_to_a" {
  route_table_id = aws_route_table.vpc_c_private_rt.id
  destination_cidr_block = "10.0.0.0/16"
  transit_gateway_id = aws_ec2_transit_gateway.main_tgw.id
}

resource "aws_route" "vpc_c_to_b" {
  route_table_id = aws_route_table.vpc_c_private_rt.id
  destination_cidr_block = "11.0.0.0/16"
  transit_gateway_id = aws_ec2_transit_gateway.main_tgw.id
}

resource "aws_security_group" "bastion_sg" {
  name = "Bastion-SG"
  description = "Security group for bastion server"
  vpc_id = aws_vpc.vpc_a.id

  ingress {
    description = "SSH from anywhere"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
  }

  ingress {
    description = "ICMP from VPC B and C"
    from_port = -1
    to_port = -1
    cidr_blocks = [var.vpc_b_cidr,var.vpc_c_cidr]
    protocol = "icmp"
  }

  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name        = "Bastion-SG"
    Environment = "dev"
  }
}


resource "aws_security_group" "vpc_b_ec2_private_sg" {
  name = "VPC-B-Ec2-Private-SG"
  description = "Security group for VPC B Private server"
  vpc_id = aws_vpc.vpc_b.id

  ingress {
    description = "SSH from VPC A TO B"
    from_port = 22
    to_port = 22
    cidr_blocks = ["10.0.0.0/16"]
    protocol = "tcp"
  }

  ingress {
    description = "ICMP from VPC A and C"
    from_port = -1
    to_port = -1
    cidr_blocks = [var.vpc_a_cidr,var.vpc_c_cidr]
    protocol = "icmp"
  }

  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name        = "VPC-B-Ec2-Private-SG"
    Environment = "dev"
  }
}

resource "aws_security_group" "vpc_c_ec2_private_sg" {
  name = "VPC-C-Ec2-Private-SG"
  description = "Security group for VPC C Private server"
  vpc_id = aws_vpc.vpc_c.id

  ingress {
    description = "SSH from VPC A TO C"
    from_port = 22
    to_port = 22
    cidr_blocks = ["10.0.0.0/16"]
    protocol = "tcp"
  }

  ingress {
    description = "ICMP from VPC A and B"
    from_port = -1
    to_port = -1
    cidr_blocks = [var.vpc_a_cidr,var.vpc_b_cidr]
    protocol = "icmp"
  }

  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name        = "VPC-C-Ec2-Private-SG"
    Environment = "dev"
  }
}

resource "aws_instance" "bastion_server_vpc_a" {
  ami = data.aws_ami.main_ami.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.vpc_a_public_subnet.id
  vpc_security_group_ids = [ aws_security_group.bastion_sg.id ]
  key_name = var.ec2_key_name

  tags = {
    Name        = "Bastion-Server-VPC-A"
    Environment = "dev"
    Region      = var.aws_region
  }

}

resource "aws_instance" "private_server_vpc_b" {
  ami = data.aws_ami.main_ami.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.vpc_b_private_subnet.id
  vpc_security_group_ids = [ aws_security_group.vpc_b_ec2_private_sg.id ]
  key_name = var.ec2_key_name

  tags = {
    Name        = "Private-Server-VPC-B"
    Environment = "dev"
    Region      = var.aws_region
  }

}

resource "aws_instance" "private_server_vpc_c" {
  ami = data.aws_ami.main_ami.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.vpc_c_private_subnet.id
  vpc_security_group_ids = [ aws_security_group.vpc_c_ec2_private_sg.id ]
  key_name = var.ec2_key_name

  tags = {
    Name        = "Private-Server-VPC-C"
    Environment = "dev"
    Region      = var.aws_region
  }

}