variable "region"{
    type = string
}
variable "vpc_cidr_block"{
    type = string
}
variable "public_subnet_cidr_block"{
    type = string
}
variable "public_subnet_az" {
    type = string
  }
variable "private_subnet_az" {
    type = string
}
variable "env"{
    type = string
}
variable "private_subnet_cidr_block" {
  type = string
}