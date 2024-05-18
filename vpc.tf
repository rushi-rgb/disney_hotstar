## vpc creation
resource "aws_vpc" "myvpc" {
  instance_tenancy = "default"
  cidr_block       = "100.100.0.0/16"
  tags = {
    Name = "Abhay-VPC1"
  }
}

### gateway
resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "Abhay-VPC1-IGW1"
  }
}
### Route Table
resource "aws_route_table" "myroute1" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygw.id
  }
}
## Subnet
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "100.100.100.0/24"
  tags = {
    Name = "Abhay-VPC1-subnet1"
  }
}
## Route table Association
resource "aws_route_table_association" "myroute_asso" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.myroute1.id
}

## Security Group with HTTP and SSH Access
resource "aws_security_group" "Project-v-sg" {
  name        = "Project V"
  description = "Security Group for Project-V "
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "disney_hotstar"
    from_port        = 5000
    to_port          = 5000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "minikube"
    from_port        = 6443
    to_port          = 6443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "nodeport"
    from_port        = 30000
    to_port          = 30000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Project V"
  }
}

