output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "igw_id" {
  value = aws_internet_gateway.igw.id
}
output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}
output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}
output "eip_address" {
  value = aws_eip.nat_eip.address
}
output "nat_id" {
  value = aws_nat_gateway.ngw.id
}