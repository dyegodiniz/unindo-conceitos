resource "aws_key_pair" "chave-tf-1" {
  key_name   = "chave-tf-1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDO+kBKNX1XRahpE+Oa0cydV8fnb72fXLGt4h3+aMoX7Mm/7sfs650zI18H4GI5RtN8ZL45YwZIsl6NzKtkrxeOx1f40WncRihqIuBVdqAfruPnPeHyF1mVQSbc3Vjqi8vG8XjIUfIvmWFBzuQNaCd/x1EKT/lncxb555jOo7uFDr5kYWnQ78hWExsDyW/Ngcfxwy+IC/kWWRh65Xbf/2mIZ+94MIeYYC4L5Ux44fJy3uk54BUIIRSSpmDyKH/IAasyX2U3nBviI3/A5VI96nTfVnf5Es4vTjqGE98cpYyHF0G3x/ZCKZ05oeim+QjuEM4X/c39ZdKRIim95XB6YW8J ubuntu"
}


## vm1 ####################################################################################################################################
resource "aws_instance" "dev-k8s-master" {
  ami                         = "ami-0eea504f45ef7a8f7"
  instance_type               = "t3a.small"
  key_name                    = aws_key_pair.chave-tf-1.key_name
  subnet_id                   = aws_subnet.publicsubnets.id
  associate_public_ip_address = true
  private_ip                  = "10.22.1.200"
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
  tags = {
    "Name"   = "dev-k8s-master"
    "deploy" = "terraformdeploy"
  }
}

resource "aws_eip" "master" {
  vpc = true

  instance                  = aws_instance.dev-k8s-master.id
  associate_with_private_ip = "10.22.1.200"
  depends_on                = [aws_internet_gateway.IGW]
  
  tags = {
    "Name"   = "master-eip"
    "deploy" = "terraformdeploy"
  }

}

output "master-instance_name" {
  value = aws_instance.dev-k8s-master.tags.Name
}

output "master-instance_ip_public" {
  value = aws_instance.dev-k8s-master.public_ip
}

# vm2 ####################################################################################################################################
resource "aws_instance" "dev-k8s-worker1" {
  ami                         = "ami-0eea504f45ef7a8f7"
  instance_type               = "t3a.small"
  key_name                    = aws_key_pair.chave-tf-1.key_name
  subnet_id                   = aws_subnet.publicsubnets.id
  associate_public_ip_address = true
  private_ip                  = "10.22.1.201"
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
  tags = {
    "Name"   = "dev-k8s-worker1"
    "deploy" = "terraformdeploy"
  }
}

resource "aws_eip" "worker1" {
  vpc = true

  instance                  = aws_instance.dev-k8s-worker1.id
  associate_with_private_ip = "10.22.1.201"
  depends_on                = [aws_internet_gateway.IGW]
  
  tags = {
    "Name"   = "worker1-eip"
    "deploy" = "terraformdeploy"
  }

}

output "worker1-instance_name" {
  value = aws_instance.dev-k8s-worker1.tags.Name
}

output "worker1-instance_ip_public" {
  value = aws_instance.dev-k8s-worker1.public_ip
}

# vm3 ####################################################################################################################################
resource "aws_instance" "dev-k8s-worker2" {
  ami                         = "ami-0eea504f45ef7a8f7"
  instance_type               = "t3a.small"
  key_name                    = aws_key_pair.chave-tf-1.key_name
  subnet_id                   = aws_subnet.publicsubnets.id
  associate_public_ip_address = true
  private_ip                  = "10.22.1.202"
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
  tags = {
    "Name"   = "dev-k8s-worker2"
    "deploy" = "terraformdeploy"
  }
}

resource "aws_eip" "worker2" {
  vpc = true

  instance                  = aws_instance.dev-k8s-worker2.id
  associate_with_private_ip = "10.22.1.202"
  depends_on                = [aws_internet_gateway.IGW]
  
  tags = {
    "Name"   = "worker2-eip"
    "deploy" = "terraformdeploy"
  }

}

output "worker2-instance_name" {
  value = aws_instance.dev-k8s-worker2.tags.Name
}

output "worker2-instance_ip_public" {
  value = aws_instance.dev-k8s-worker2.public_ip
}

# vm 4 ####################################################################################################################################
resource "aws_instance" "gitlab-runner" {
  ami                         = "ami-0eea504f45ef7a8f7"
  instance_type               = "t3a.small"
  key_name                    = aws_key_pair.chave-tf-1.key_name
  subnet_id                   = aws_subnet.publicsubnets.id
  associate_public_ip_address = true
  private_ip                  = "10.22.1.203"
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
  tags = {
    "Name"   = "gitlab-runner"
    "deploy" = "terraformdeploy"
  }
}

output "gitlab-runner-instance_name" {
  value = aws_instance.gitlab-runner.tags.Name
}

output "gitlab-runner-instance_ip_public" {
  value = aws_instance.gitlab-runner.public_ip
}

# vm5 ####################################################################################################################################
resource "aws_instance" "lb" {
  ami                         = "ami-0eea504f45ef7a8f7"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.chave-tf-1.key_name
  subnet_id                   = aws_subnet.publicsubnets.id
  associate_public_ip_address = true
  private_ip                  = "10.22.1.204"
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
  tags = {
    "Name"   = "lb"
    "deploy" = "terraformdeploy"
  }
}

resource "aws_eip" "lb" {
  vpc = true

  instance                  = aws_instance.lb.id
  associate_with_private_ip = "10.22.1.204"
  depends_on                = [aws_internet_gateway.IGW]
  
  tags = {
    "Name"   = "lb-eip"
    "deploy" = "terraformdeploy"
  }

}

output "lb-instance_name" {
  value = aws_instance.lb.tags.Name
}

output "lb-instance_ip_public" {
  value = aws_instance.lb.public_ip
}