resource "aws_network_interface" "bc_interface1" {
  subnet_id       = aws_subnet.bc_subnet1.id
  private_ips     = ["10.0.0.50"]

  security_groups = [aws_security_group.bc_security1.id]

}

resource "aws_subnet" "bc_subnet1" {
  vpc_id     = aws_vpc.bc_network1.id
  cidr_block = "10.0.0.0/16"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Main"
  }
}

resource "aws_security_group" "bc_security1" {

    ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.bc_network1.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.bc_network1.ipv6_cidr_block]
  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.bc_network1.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.bc_network1.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_vpc" "bc_network1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

