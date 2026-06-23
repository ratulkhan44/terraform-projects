# Data source for Primary region AMI (Ubuntu 24.04 LTS)
data "aws_ami" "main_ami" {
  most_recent = true
  owners = [ "099720109477" ]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}