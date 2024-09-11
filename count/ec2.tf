resource "aws_security_group" "Allowall" {
    name = "Terrasg"
    description = "It allows all conncetions on port 22"

    ingress {

        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {

        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {

        name = "Terrasg"
    }
}

resource "aws_instance"  "example" {
    count = 3
    # name = " terraSever "
    # description = "Terraform created this server "
    ami = "ami-09c813fb71547fc4f"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.Allowall.id]
    tags = {
        name = var.Instanames[count.index]
    }
}