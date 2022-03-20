# API provider.
terraform {
  required_providers {
    aws = {
      source = "terraform-registry.storage.yandexcloud.net/hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Security keys.
resource "aws_key_pair" "login" {
  key_name   = "login"
  public_key = file("~/.ssh/id_rsa.pub")
}

# VM type.
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Instance of VM to create.
resource "aws_instance" "vm" {
  # Ubuntu 20.04 for us-east-1.
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  user_data = file("init-script.sh")

  key_name = aws_key_pair.login.id

  vpc_security_group_ids = [aws_security_group.vm-security.id]

  tags = {
    Name = var.instance_name
  }
}

# Network security.
resource "aws_security_group" "vm-security" {
  name = var.security_group_name
  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}