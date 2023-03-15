output "INSTANCE_PUBLIC_IP" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.jenkins-instance.public_ip
}