output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet" {
  value = aws_subnet.private1.id
}
