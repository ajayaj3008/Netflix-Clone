output "instance_id" {
  value = aws_instance.demo.id
}

output "instance_public_ip" {
  value = aws_instance.demo.public_ip
}

output "private_key_pem" {
  value     = tls_private_key.app_key.private_key_pem
  sensitive = true
}