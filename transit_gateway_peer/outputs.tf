output "vpc_a_id" {
  description = "ID of the VPC A"
  value       = aws_vpc.vpc_a.id
}

output "vpc_b_id" {
  description = "ID of the VPC B"
  value       = aws_vpc.vpc_b.id
}

output "vpc_c_id" {
  description = "ID of the VPC C"
  value       = aws_vpc.vpc_c.id
}

output "bastion_server_public_ip" {
  description = "Public IP for Bastion Server"
  value       = aws_instance.bastion_server_vpc_a.public_ip
}

output "bastion_server_private_ip" {
  description = "Private IP for Bastion Server"
  value       = aws_instance.bastion_server_vpc_a.private_ip
}

output "vpc-b-instance-private-ip" {
  description = "Private IP for VPC-B instance Server"
  value       = aws_instance.private_server_vpc_b.private_ip
}

output "vpc-c-instance-private-ip" {
  description = "Private IP for VPC-C instance Server"
  value       = aws_instance.private_server_vpc_c.private_ip
}

output "aws_main_transit_gateway_id" {
  description = "Main Transit gateway ID"
  value = aws_ec2_transit_gateway.main_tgw.id
}

output "test_connectivity_command" {
  description = "Command to test connectivity between VPCs"
  value       = <<-EOT
    To test VPC Transit Gateway connectivity:
    1. Copy private key to bastion server : scp -i "${var.ec2_key_name}.pem" ${var.ec2_key_name}.pem ubuntu@${aws_instance.bastion_server_vpc_a.public_ip}:~/.ssh/
    2. SSH into Bastion Server: ssh -i ${var.ec2_key_name}.pem ubuntu@${aws_instance.bastion_server_vpc_a.public_ip}
    3. Set proper permissions for private key: chmod 600 ~/.ssh/${var.ec2_key_name}.pem
    4. Test ping from Bastion to VPC-B instance: ping ${aws_instance.private_server_vpc_b.private_ip}
    5. Test ping from Bastion to VPC-C instance: ping ${aws_instance.private_server_vpc_c.private_ip}
    6. SSH into VPC-B instance : ssh -i ~/.ssh/${var.ec2_key_name}.pem ubuntu@${aws_instance.private_server_vpc_b.private_ip}
    7. Test ping from VPC-B instance to VPC-C instance : ping ${aws_instance.private_server_vpc_c.private_ip}
    8. Test ping from VPC-B instance to VPC-A instance : ping ${aws_instance.bastion_server_vpc_a.private_ip}
    9. SSH into VPC-C instance : ssh -i ~/.ssh/${var.ec2_key_name}.pem ubuntu@${aws_instance.private_server_vpc_c.private_ip}
    10. Test ping from VPC-C instance to VPC-B instance : ping ${aws_instance.private_server_vpc_b.private_ip}
    11. Test ping from VPC-C instance to VPC-A instance : ping ${aws_instance.bastion_server_vpc_a.private_ip}
  EOT
}