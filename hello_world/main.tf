terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-02b8269d5e85954ef" # Ubuntu 20.04 LTS // us-east-1
  instance_type = "t2.micro"
}