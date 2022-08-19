resource "aws_instance" "bc_instance" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"

  key_name = data.aws_key_pair.bootcamp_key.key_name

  root_block_device {
    delete_on_termination = false
    volume_size           = var.volume_size
  }

  network_interface {
    network_interface_id = aws_network_interface.bc_interface1.id
    device_index         = 0
  }

  tags = {
    Name = "Lab Instance"
  }
}