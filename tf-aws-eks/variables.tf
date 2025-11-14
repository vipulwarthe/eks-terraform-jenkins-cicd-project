##############################
# AWS CONFIGURATION
##############################

variable "aws_region" {
  description = "AWS region where infrastructure is deployed"
  type        = string
  # default   = "us-east-1"
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

##############################
# VPC CONFIGURATION
##############################

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDR ranges"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDR ranges"
  type        = list(string)
}

##############################
# EC2 / EKS CONFIGURATION
##############################

variable "instance_type" {
  description = "EC2 instance type for Jenkins / Workers"
  type        = string
  # default   = "t3.medium"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  # default   = "my-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string
  # default   = "1.29"
}

variable "min_size" {
  description = "Minimum number of nodes in Node Group"
  type        = number
  # default   = 1
}

variable "max_size" {
  description = "Maximum number of nodes in Node Group"
  type        = number
  # default   = 3
}

variable "desired_size" {
  description = "Desired number of nodes"
  type        = number
  # default   = 2
}

variable "node_instance_types" {
  description = "EC2 instance types for EKS managed node group"
  type        = list(string)
  # default   = ["t3.small"]
}
