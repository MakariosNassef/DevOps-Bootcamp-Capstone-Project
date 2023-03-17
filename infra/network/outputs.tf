output "PRIVATE_SUBNET_ID_OUTPUT" {
  value = aws_subnet.private_us_east_1a.id
}

output "PUBLIC_SUBNET_ID_OUTPUT" {
  value = aws_subnet.public_us_east_1b.id
}

output "PUBLIC_SUBNET_ID_OUTPUT_2" {
  value = aws_subnet.public_us_east_2a.id
}


output "VPC_ID_OUTPUT" {
  value = aws_vpc.main.id
}