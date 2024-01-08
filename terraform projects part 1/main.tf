# Configure AWS provider
provider "aws" {
  region  = "eu-west-2"
  profile = "terraform-user"
}

# Stores the Terraform state file in S3
terraform {
  backend "s3" {
    bucket = "terraformbucket321"
    key    = "C:/Users/krita/Desktop/Terraform-Projects/terraform.tfstate"
    region = "eu-west-2"
    profile = "terraform-user"
  }
}

