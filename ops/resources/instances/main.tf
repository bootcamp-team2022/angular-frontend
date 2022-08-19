resource "aws_instance" "bc_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"

 network_interface {
    network_interface_id = aws_network_interface.bc_interface1.id
    device_index         = 0
  }

  tags = {
    Name = "Lab Instance 2"
  }
}

resource "aws_ebs_volume" "bc_volume1" {
  availability_zone = "us-east-1a"
  size              = var.volume_size

  tags = {
    Name = "Test Volume"
  }
}