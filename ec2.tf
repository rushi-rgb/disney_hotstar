provider "aws" {
  region = "us-east-1"
}

## VM with user data for webserver
resource "aws_instance" "myinstance1" {
  ami                         = "ami-09040d770ffe2224f"
  instance_type               = "t2.medium"
  key_name                    = var.myvar1
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet1.id
  vpc_security_group_ids      = [aws_security_group.Project-v-sg.id]
  user_data                   = base64encode(file("user-data.sh"))
  tags = {
    Name = "Project V"
  }
  root_block_device {
    volume_size = "20"  # Size in GB
    volume_type = "gp2" # EBS volume type
  }

}

output "host_ip" {
  value = aws_instance.myinstance1.public_ip
}
output "instance_state" {
  description = "The state of the ec2 instance "
  value       = aws_instance.myinstance1.*.instance_state
}
variable "myvar1" {
  type = string
  default= "ohio"
}
