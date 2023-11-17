resource "aws_instance" "jenkins-agent" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.medium"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = [aws_security_group.ingress-ssh-from-all.id]

  key_name = "jenkins-server-key"
}