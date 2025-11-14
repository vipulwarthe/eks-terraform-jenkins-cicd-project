terraform {
  backend "s3" {
    bucket = "terraform-eks-cicd-7001"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"

    # Optional but recommended:
    # dynamodb_table = "terraform-locks"
    # encrypt        = true
  }
}
