variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "public_ip_association"{
    type = bool
}
variable "subnet_id" {
    type = string
}
variable "user_data" {
    type = string
    default = ""
}
variable "key_name" {
    type = string
}
variable "vpc_id"{
    type = string
}
variable "my_ip" {
    type = string
}
variable "instance_rule" {
    type = string
}
variable "iam_instance_profile" {
  type = string
}