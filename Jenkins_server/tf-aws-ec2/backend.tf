# -----------------------------------------------------------------------------
# TERRAFORM BACKEND (S3 + DynamoDB)
# -----------------------------------------------------------------------------
# NOTE:
# Backend does NOT allow using variables.
# Provide values using: terraform init -backend-config
# -----------------------------------------------------------------------------

terraform {
  backend "s3" {
    # These values must be passed during 'terraform init'
    # Example:
    # terraform init \
    #   -backend-config="bucket=jenkins-tfstate-bucket-1617" \
    #   -backend-config="key=jenkins/terraform.tfstate" \
    #   -backend-config="region=us-east-1" \
    #   -backend-config="dynamodb_table=terraform-locks" \
    #   -backend-config="encrypt=true"

    bucket         = "jenkins-tfstate-bucket-1617"
    key            = "jenkins/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

    # Optional but recommended:   add below dynamodb table line beore "encryt"
    # dynamodb_table = "terraform-locks"
    # encrypt        = true
