output "vpc_id" {
  value = aws_vpc.Task6-VPC-Zaeem.id
}

output "public_sna_id" {
  value = aws_subnet.Task6-Public-SubnetA-Zaeem.id
}

output "public_snb_id" {
  value = aws_subnet.Task6-Public-SubnetB-Zaeem.id
}

output "private_sna_id" {
  value = aws_subnet.Task6-Private-SubnetA-Zaeem.id
}

output "private_snb_id" {
  value = aws_subnet.Task6-Private-SubnetB-Zaeem.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.Task6-NAT-Gateway-Zaeem.id
}
