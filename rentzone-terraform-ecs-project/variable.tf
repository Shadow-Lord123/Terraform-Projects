# Environment variables
variable "region" {
  description = "region to create resources"
  type        = string 
}

variable "project_name" {
  description = "project name"
  type        = string 
}

variable "environment" {
  description = "environment"
  type        = string 
}

variable "vpc_cidr" {
  description = "vpc cidr block"
  type        = string 
}

variable "public_subnet_az1_cidr" {
  description = "public subnet az1 cidr block"
 type        = string 
}

variable "public_subnet_az2_cidr" {
  description = "public subnet az2 cidr block"
  type        = string 
}

variable "private_app_subnet_az1_cidr" {
  description = "private app subnet az1 cidr block"
  type        = string 
}

variable "private_app_subnet_az2_cidr" {
  description = "private app subnet az2 cidr block"
  type        = string 
}


variable "private_data_subnet_az1_cidr" {
  description = "private data subnet az2 cidr block"
  type        = string 
}

variable "private_data_subnet_az2_cidr" {
  description = "private data subnet az2 cidr block"
  type        = string 
}

variable "ssh_location" {
  description = "ip address that can ssh into server"
  type        = string 
}

variable "domain_name" {
  description = "domain name"
  type        = string 
}

variable "alternative_names" {
  description = "sub domain name"
  type        = string 
}

# s3 variables
variable "env_file_bucket_name" {
  description = "s3 bucket group"
  type        = string
}

variable "env_file_name" {
  description = "env file name"
  type        = string
}

variable "container_image_uri" {
  default = "233966445372.dkr.ecr.eu-west-2.amazonaws.com/repository:rentzone"
  description = "container image uri"
  type        = string
}

#rds variables

variable "database_snapshot_identifier" {
  description = "database snapshot name"
  type        = string
}

variable "database_instance_class" {
  description = "the database instance type"
  type        = string
}

variable "database_instance_identifier" {
  description = "the database instance identifier"
  type        = string
}

variable "multi_az_deployment" {
  default = false
  description = "database instance identifier"
  type        = bool
}

variable "ssl_certificate_arn" {
  default = "arn:aws:acm:eu-west-2:233966445372:certificate/8e81786c-5f7e-458d-a034-af83681e2e7e"
  description = "ssl certificate arn"
  type        = string
}

variable "architecture" {
  description = "ecs cpu architecture"
  type        = string
}
# route 53 variables
variable "record_name" {
  description = "sub domain name"
  type        = string
}
