resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block

    tags = {
      name = "${var.env}-vpc"
    }
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
  
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr_block
    map_public_ip_on_launch = true
    availability_zone = var.public_subnet_az
    tags = {
      name = "${var.env}-public-subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_cidr_block
    map_public_ip_on_launch = false
    availability_zone = var.private_subnet_az
    tags = {
      name = "${var.env}-public-subnet"
    }
}

resource "aws_route_table" "public_subnet_route_table" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "association_for_public_subnet" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_subnet_route_table.id
}

resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = {
        name = "nat-eip"
    }
}

resource "aws_nat_gateway" "ngw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_subnet.id
    tags = {
      name = "${var.env}-nat-gateway"
    }
    depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private_subnet_route_table" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.ngw.id
    }
}
resource "aws_route_table_association" "association_for_private_subnet" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_subnet_route_table.id
}