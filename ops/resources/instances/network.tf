resource "aws_network_interface" "bc_interface1" {
  subnet_id       = aws_subnet.bc_subnet1.id
  security_groups = [aws_security_group.bc_security1.id]
}

resource "aws_subnet" "bc_subnet1" {
  vpc_id            = aws_vpc.bc_network1.id
  cidr_block        = aws_vpc.bc_network1.cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = "Main"
  }
}

resource "aws_security_group" "bc_security1" {
  vpc_id = aws_vpc.bc_network1.id

  ingress {
      cidr_blocks = [
        "0.0.0.0/0"
  ]

  from_port = 22
      to_port = 22
      protocol = "tcp"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "basic_security"
  }
}

resource "aws_vpc" "bc_network1" {
  cidr_block       = "10.0.0.192/26"
  instance_tenancy = "default"

  tags = {
    Name = "Bootcamp VPC 1"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.bc_network1.id

  tags = {
    Name = "Bootcamp IGW"
  }
}

resource "aws_eip" "elastic" {
  instance = aws_instance.bc_instance.id
  vpc      = true
}

