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
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "public_ip_association"{
    type = bool
}
# variable "user_data" {
#     type = string
#     default = "${path.module}/user_script.sh"
# }
variable "key_name" {
    type = string
}
variable "instance_rule" {
    type = string
}
variable "bucket_name" {
  type = string
}
variable "key_file" {
    type = string
}
variable "resume_file_path" {
  type = string
}
variable "content_type" {
    type = string
}
