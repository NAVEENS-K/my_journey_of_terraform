output "vpc_id" {
  value = module.vpc.vpc_id
}
output "igw_id" {
  value = module.vpc.igw_id
}
output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}
output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}
output "eip_address" {
  value = module.vpc.eip_address
}
output "nat_id" {
  value = module.vpc.nat_id
}
output "ec2_id" {
  value = module.public_ec2.ec2_id
}
output "ec2_public_ip" {
    value = module.public_ec2.ec2_public_ip
}
output "ec2_private_ip" {
  value = module.public_ec2.ec2_private_ip
}
output "ec2_key_name" {
  value = module.public_ec2.ec2_key
}
output "s3_resume_url" {
  value = module.s3.s3_resume_url
}
output "instance_profile_name" {
  value = module.iam_policy_rule_instance_profile.instance_profile_name
}