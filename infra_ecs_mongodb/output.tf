output "ec2_id" {
  value = aws_instance.mongodb_instance.id
}

output "ec2_dns" {
  value = aws_instance.mongodb_instance.public_dns
}

output "nlb_dns" {
  value = var.nlb_enabled ? aws_lb.mongodb_lb.*.dns_name : null
}
