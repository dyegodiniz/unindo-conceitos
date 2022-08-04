resource "aws_vpc" "Main" {
  cidr_block       = var.main_vpc_cidr
  instance_tenancy = "default"
  tags = {
    "Name"   = "vpc-tf"
    "deploy" = "terraformdeploy"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.Main.id
  cidr_block = var.subnet1
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    "Name"   = "sub-tf-1"
    "deploy" = "terraformdeploy"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.Main.id
  cidr_block = var.subnet2
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true
  tags = {
    "Name"   = "sub-tf2"
    "deploy" = "terraformdeploy"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Main.id
  tags = {
    "Name"   = "igw-tf-rede-pub-dev"
    "deploy" = "terraformdeploy"
  }
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.Main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    "Name"   = "rt-tf-rede-pub-dev"
    "deploy" = "terraformdeploy"
  }
}

# resource "aws_route_table_association" "PublicRTassociation" {
#   #subnet_id      = aws_subnet.subnet1.id
#   subnet_id      = [aws_subnet.subnet1.id,aws_subnet.subnet2.id]
#   route_table_id = aws_route_table.PublicRT.id
# }

resource "aws_route_table_association" "a" {
  #subnet_id      = aws_subnet.subnet1.id
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_route_table_association" "b" {
  #subnet_id      = aws_subnet.subnet1.id
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.PublicRT.id
}



resource "aws_eip" "nateIP" {
  vpc = true
}

###
# Public Security Group
##

resource "aws_security_group" "ec2-sg" {
  name        = "tf-dev-ec2-sg"
  description = "Public internet access"
  vpc_id      = aws_vpc.Main.id

  tags = {
    Name        = "tf-dev-ec2-sg"
    Role        = "public"
    Project     = "dev"
    Environment = "dev"
    "deploy"    = "terraformdeploy"
  }
}

resource "aws_security_group_rule" "public_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2-sg.id
  description       = "saida default"
}

resource "aws_security_group_rule" "public_in_interno" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.22.0.0/16"]
  security_group_id = aws_security_group.ec2-sg.id
  description       = "acesso total da rede dentro da mesma vpc"
}

# resource "aws_security_group_rule" "public_in_ssh" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["177.202.171.238/32"]
#   security_group_id = aws_security_group.ec2-sg.id
#   description       = "acesso ssh dyego"
# }

resource "aws_security_group_rule" "public_in_all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["177.202.171.238/32"]
  security_group_id = aws_security_group.ec2-sg.id
  description       = "acesso all dyego"
}

resource "aws_security_group_rule" "public_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2-sg.id
  description       = "acesso todos http"
}

resource "aws_security_group_rule" "public_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2-sg.id
  description       = "acesso todos https"
}

###
# Public Security Group
##