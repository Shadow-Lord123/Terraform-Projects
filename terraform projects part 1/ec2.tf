# Configured AWS provider with proper credentials
provider "aws" {
  alias   = "myprovider"  # Set an alias for this provider configuration
  region  = "eu-west-2"
  profile = "terraform-user"
}

# Create default VPC if one does not exist
resource "aws_default_vpc" "default_vpc" {
  provider = aws.myprovider  # Reference the provider alias

  tags = {
    Name = "Default Vpc"
  }
}

# Use data source to get all availability zones in the region
data "aws_availability_zones" "available_zones" {
  provider = aws.myprovider  # Reference the provider alias
}

# Create default subnet if one does not exist
resource "aws_default_subnet" "default_az1" {
  provider           = aws.myprovider  # Reference the provider alias
  availability_zone  = data.aws_availability_zones.available_zones.names[0]

  tags = {
    Name = "Default Subnet"
  }
}

# Create security group for the EC2 instance
resource "aws_security_group" "ec2_security_group" {
  provider      = aws.myprovider  # Reference the provider alias
  name          = "ec2 security group"
  description   = "allow access on ports 80 and 22"
  vpc_id        = aws_default_vpc.default_vpc.id  # Use the VPC ID from the default VPC resource

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["18.168.47.123/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2 Security Group"
  }
}

# Use data source to get a registered Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  provider   = aws.myprovider  # Reference the provider alias
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Launch the EC2 instance and install website
resource "aws_instance" "ec2_instance" {
  provider               = aws.myprovider  # Reference the provider alias
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  key_name               = "mykeypair"
  user_data              = file("install_website.sh")

  tags = {
    Name = "techmax server"
  }
}

# Print the EC2's public IPv4 address
output "public_ipv4_address" {
  value = aws_instance.ec2_instance.public_ip
}
