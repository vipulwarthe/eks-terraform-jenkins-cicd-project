variable "aws_region" {
  description = "us-east-1"
  type        = string
}

variable "aws_account_id" {
  description = "717279727098"
  type        = string
}

variable "backend_jenkins_bucket" {
  description = "S3 bucket where Jenkins Terraform state file will be stored"
  type        = string
}

variable "backend_jenkins_bucket_key" {
  description = "S3 bucket key for the Jenkins Terraform state file"
  type        = string
}

variable "vpc_name" {
  description = "Name for the Jenkins VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for Jenkins VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 Instance type for Jenkins Server"
  type        = string
}

variable "jenkins_security_group" {
  description = "Name of the Jenkins EC2 Security Group"
  type        = string
}

variable "jenkins_ec2_instance" {
  description = "Name of the Jenkins EC2 Instance"
  type        = string
}
