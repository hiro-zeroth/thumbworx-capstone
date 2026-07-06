output "vpc_id" {
  value = aws_vpc.thumbworx_vpc.id
}

output "public_ip" {
  value = aws_instance.thumbworx.public_ip
}