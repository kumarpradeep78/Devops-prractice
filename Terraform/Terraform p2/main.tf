# VPC 
resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "AppVPC" }
}

# Subnet
 
resource "aws_subnet" "app_subnet" {
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = { Name = "AppSubnet" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = { Name = "AppIGW" }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.app_vpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.rt.id
}


# Flask SG
resource "aws_security_group" "flask_sg" {
  name        = "flask-sg"
  description = "Allow Flask port and SSH"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.flask_port
    to_port     = var.flask_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Express SG
resource "aws_security_group" "express_sg" {
  name        = "express-sg"
  description = "Allow Express port and SSH"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.express_port
    to_port     = var.express_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance flask

resource "aws_instance" "flask" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.app_subnet.id
  vpc_security_group_ids = [aws_security_group.flask_sg.id]

  tags = { Name = "Flask-Server" }

  provisioner "file" {
    source      = "Backend"
    destination = "/home/ubuntu/Backend"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y python3 python3-pip",
      "sudo apt install -y python3-flask",
      "nohup python3 /home/ubuntu/Backend/app.py > /home/ubuntu/Backend/flask.log 2>&1 &"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }
}


#EC2 instance for Frontend Express/node
resource "aws_instance" "express" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.app_subnet.id
  vpc_security_group_ids = [aws_security_group.express_sg.id]

  tags = { Name = "Express-Server" }

  provisioner "file" {
    source      = "Frontend"
    destination = "/home/ubuntu/Frontend"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nodejs npm",
      "cd /home/ubuntu/Frontend && npm install",
      "nohup node /home/ubuntu/Frontend/app.js > /home/ubuntu/Frontend/node.log 2>&1 &"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }
}

