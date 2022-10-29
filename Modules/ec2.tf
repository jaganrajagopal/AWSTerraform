resource "aws_instance" "ec2instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "Kering Test"
  }
}