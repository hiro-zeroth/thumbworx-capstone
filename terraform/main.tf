resource "aws_vpc" "thumbworx_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Thumbworx-VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.thumbworx_vpc.id

  cidr_block = "10.0.1.0/24"

  map_public_ip_on_launch = true

  tags = {
    Name = "Thumbworx-Public-Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.thumbworx_vpc.id

  tags = {
    Name = "Thumbworx-IGW"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.thumbworx_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Thumbworx-Public-RT"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "thumbworx_sg" {
  name   = "thumbworx-security-group"
  vpc_id = aws_vpc.thumbworx_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Thumbworx-SG"
  }
}

resource "aws_instance" "thumbworx" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.thumbworx_sg.id]

  tags = {
    Name = var.instance_name
  }
}