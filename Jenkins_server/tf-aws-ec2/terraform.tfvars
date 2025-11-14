aws_region = "us-east-1"
aws_account_id = "717279727098"
backend_jenkins_bucket = "jenkins-tfstate-bucket-1617"
backend_jenkins_bucket_key = "jenkins/terraform.tfstate"


vpc_name = "jenkins-vpc"
vpc_cidr = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]


instance_type = "t3.medium"
jenkins_security_group = "jenkins-sg"
jenkins_ec2_instance = "jenkins-server"
