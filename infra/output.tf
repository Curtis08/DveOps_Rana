output "instance_public_ip" {
 value = aws_instance.web.public_ip
 }
 output "eip_public_ip" {
 value = aws_eip.eip.public_ip
 }