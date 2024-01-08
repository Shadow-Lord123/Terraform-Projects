#vpc variable
variable "vpc_cidr" {
default = "10.0.0.0/16"
description = "vpc cidr block"
type = string
}

variable "public_subnet_az1" {
default = "10.0.0.0/24"
description = "vpc cidr block"
type = string
}

variable "public_subnet_az2" {
default = "10.0.1.0/24"
description = "vpc cidr block"
type = string
}

variable "private_app_subnet_az1" {
default = "10.0.2.0/24"
description = "vpc cidr block"
type = string
}

variable "private_app_subnet_az2" {
default = "10.0.3.0/24"
description = "vpc cidr block"
type = string
}

variable "private_data_subnet_az1" {
default = "10.0.4.0/24"
description = "vpc cidr block"
type = string
}

variable "private_data_subnet_az2" {
default = "10.0.5.0/24"
description = "vpc cidr block"
type = string
}

variable "ssh_location" {
default = "0.0.0.0/0"
description = "the ip address that can ssh into the ec2 instance"
type = string
}

# application load balancer variables
variable "ssl_certificate_arn" {
  default       = "arn:aws:acm:eu-west-2:233966445372:certificate/5549083a-ab38-4ea9-a663-86d18de176af"
  description   = "ssl cerificate arn"
  type          = string
}

variable "operator-email" {
  default       = "kritagya@gmail.com"
  description   = "email"
  type          = string
}

