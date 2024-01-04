# configure aws provider
provider "aws" {
  region = "eu-west-2"
  profile = "terraform-user"
}

# stores the terraform state file in s3
terraform {
  backend "s3" {
    bucket = "terraformbucket321"
    key    = "terraform.tfstate.dev"
    region = "eu-west-1"
    profile = "terraform-user"
  }
}

