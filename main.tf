module "vpc" {
  source = "./modules/vpc"
  region = var.region
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  public_subnet_az = var.public_subnet_az
  private_subnet_az = var.private_subnet_az
  env = var.env
}

module "public_ec2"{
    source = "./modules/ec2"
    ami = var.ami
    instance_type = var.instance_type
    public_ip_association = var.public_ip_association
    subnet_id = module.vpc.public_subnet_id
    user_data = file("${path.module}/user_script.sh")
    key_name = var.key_name
    vpc_id = module.vpc.vpc_id
    my_ip = local.my_ip
    instance_rule = var.instance_rule
    iam_instance_profile = module.iam_policy_rule_instance_profile.instance_profile_name 
}

module "s3" {
    source = "./modules/s3"
    bucket_name = var.bucket_name
    key_file = var.key_file
    resume_file_path = var.resume_file_path
    content_type = var.content_type
}

module "iam_policy_rule_instance_profile" {
    source = "./modules/iam"
    bucket_name = var.bucket_name
    key_file = var.key_file
}

data "http" "my_ip"{
    url = "https://checkip.amazonaws.com"
}
locals{
    my_ip = chomp(data.http.my_ip.response_body)
}