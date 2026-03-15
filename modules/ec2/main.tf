resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id

  tags = {
    Name = "web-server"
  }
}
