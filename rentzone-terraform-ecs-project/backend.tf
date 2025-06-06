# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "terraformbucket321"
    key            = "rentzone-ecs/terraform.tfstate"
    region         = "eu-west-2"
    profile        = "terraform-user"
    dynamodb_table = "terraform-state-lock"
  }
}