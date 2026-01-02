terraform {
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "~>6.0"
        }
    }

}

provider "aws"{
    region ="ap-south-1"
}

resource "aws_vpc" "example_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        name = "example_vpc"
    }
  
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.example_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true

    availability_zone = "ap-south-1a"

    tags={
        name = "public_subnet"
    }
  
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.example_vpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = false

    availability_zone = "ap-south-1b"

    tags={
        name = "private_subnet"
    }
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.example_vpc.id
  
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "demo-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}


resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.example_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.example_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
}



resource "aws_route_table_association" "public_rt_associaion" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_associaion" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_rt.id
}



resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.example_vpc.id
}

resource "aws_security_group_rule" "public_icmp" {
  type              = "ingress"
  security_group_id = aws_security_group.public_sg.id

  protocol    = "icmp"
  from_port   = -1
  to_port     = -1
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "public_ssh" {
    type = "ingress"
    security_group_id = aws_security_group.public_sg.id
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  
}

resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.example_vpc.id
}

resource "aws_security_group_rule" "private_icmp" {
  type              = "ingress"
  security_group_id = aws_security_group.private_sg.id

  protocol    = "icmp"
  from_port   = -1
  to_port     = -1
  cidr_blocks = ["10.0.0.0/16"]
}

resource "aws_security_group_rule" "private_ssh" {
  type              = "ingress"
  security_group_id = aws_security_group.private_sg.id

  protocol    = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_blocks = ["10.0.0.0/16"]
}

resource "aws_instance" "public_ec2_instance" {
    ami = "ami-02b8269d5e85954ef"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids =[aws_security_group.public_sg.id]
    key_name = "terraform_public_subnet_ec2_key"
    tags = {
        name = "public-ec2"
    }
}

resource "aws_instance" "private_ec2_instance" {
    ami = "ami-02b8269d5e85954ef"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private_subnet.id
    vpc_security_group_ids =[aws_security_group.private_sg.id]
    key_name = "terraform_private_subnet_ec2_key"
    tags = {
        name = "private-ec2"
    }
}