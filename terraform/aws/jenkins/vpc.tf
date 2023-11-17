resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "jenkins_vpc"
  }
}
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet
  availability_zone       = "${var.AWS_REGION}a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "jenkins_subnet"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "jenkins_igw"
  }
}
resource "aws_security_group" "ingress-ssh-from-all" {
  name   = "jenkins-allow-all-ssh-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}