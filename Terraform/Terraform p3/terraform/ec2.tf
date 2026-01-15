resource "aws_instance" "ecs" {
  ami           = "ami-02b8269d5e85954ef"
  instance_type = "t3.micro"
  key_name      = var.key_name
  subnet_id     = aws_subnet.public.id
  associate_public_ip_address = true
}
