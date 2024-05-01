resource "aws_instance" "jenkins-server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.medium"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = [aws_security_group.ingress-ssh-from-all.id]

  key_name   = "jenkins-server-key"
}

resource "aws_alb" "jenkins_alb" {
  name            = "jenkins-alb"
  subnets         = [aws_subnet.subnet.id]
  security_groups = [aws_security_group.ingress-ssh-from-all.id]
  internal        = true
}

resource "aws_alb_listener" "jenkins_alb_listener" {
  load_balancer_arn = aws_alb.jenkins_alb.arn
  port              = 8080
  protocol          = "HTTP"
  }
}