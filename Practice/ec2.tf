resource "aws_security_group" "practi" {
  name        = "Practice"
  description = "enable port 22"

  ingress {
    description      = "Enabling ssh"
    from_port        = var.fropo
    to_port          = var.topo
    protocol         = var.proto
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "MineSG"
  }
}

resource "aws_instance" "practical" {
  count                  = length(var.instances)
  ami                    = data.aws_ami.pradata.id
  instance_type          = local.instatype
  vpc_security_group_ids = [aws_security_group.practi.id]
  tags = merge(
    var.common_tags,
    {
      Name = var.instances[count.index]
    }
  )

}
