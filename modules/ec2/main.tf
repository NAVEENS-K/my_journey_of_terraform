resource "aws_instance" "ec2_instance" {
    ami = var.ami
    instance_type = var.instance_type
    associate_public_ip_address = var.public_ip_association
    subnet_id = var.subnet_id
    # user_data_base64 = var.user_data
    user_data = var.user_data
    key_name = var.key_name
    security_groups = [ local.selected_sg ]
    iam_instance_profile = var.iam_instance_profile
}

resource "aws_security_group" "public_sg" {
    name = "public-sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.my_ip}/32"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "private_sg" {
    name = "private-sg"
    vpc_id = var.vpc_id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

locals {
  selected_sg = var.instance_rule == "public" ? aws_security_group.public_sg.id : aws_security_group.private_sg.id
} 