############################################
# DATA SOURCES
############################################

# Get all available availability zones in the region
data "aws_availability_zones" "azs" {
  state = "available"
}

# Get latest Ubuntu 22.04 LTS AMI (for EC2 / Jenkins)
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
