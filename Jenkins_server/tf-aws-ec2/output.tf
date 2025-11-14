output "ec2_instance_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2_instance.public_ip
}

output "ec2_instance_dns" {
description = "Public DNS of the EC2 instance"
value = module.ec2_instance.public_dns
}
