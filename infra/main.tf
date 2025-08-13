 terraform {
 required_version = ">= 1.5.0"
 required_providers {
 aws = {
 source = "hashicorp/aws"
 version = ">= 5.0"
 }
 }
 }
 provider "aws" {
 region = var.aws_region
 }
 # Latest Ubuntu 22.04 LTS AMI
 data "aws_ami" "ubuntu" {
 most_recent = true
 owners
 filter {
 name
 }
 }
 = ["099720109477"] # Canonical
 = "name"
 values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
 5
resource "aws_key_pair" "devops" {
 key_name = var.ssh_key_name
 public_key = var.ssh_public_key
 }
 resource "aws_security_group" "web_sg" {
 name = "web-sg"
 description = "Allow HTTP and SSH"
 ingress {
 description = "SSH"
 from_port = 22
 to_port = 22
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
 description = "HTTP"
 from_port = 80
 to_port = 80
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 }
 }
 resource "aws_instance" "web" {
 ami = data.aws_ami.ubuntu.id
 instance_type = var.instance_type
 key_name = aws_key_pair.devops.key_name
 vpc_security_group_ids = [aws_security_group.web_sg.id]
 tags = { Name = "devops-web" }
 user_data = <<-EOF
    #!/bin/bash
    set -e
    apt-get update -y
    apt-get install -y docker.io
    systemctl enable docker
    systemctl start docker
    usermod -aG docker ubuntu || true
 6
  EOF
 }
 # Allocate & attach Elastic IP so the host IP stays stable
 resource "aws_eip" "eip" {
 vpc = true
 tags = { Name = "devops-web-eip" }
 }
 resource "aws_eip_association" "eip_assoc" {
 instance_id
 = aws_instance.web.id
 allocation_id = aws_eip.eip.id
 }