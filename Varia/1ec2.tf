resource "aws_security_group" "Allowall" {
    name = var.sg_name
    description = var.sg_desc

    ingress {

        from_port = var.frompo
        to_port = var.topo
        protocol = var.proto
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {

        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks      = var.Incidr
        ipv6_cidr_blocks = ["::/0"]
    }

    tags =  var.Instanames[count.index]
}

resource "aws_instance"  "example" {

    count = 3
    # name = " terraSever "
    # description = "Terraform created this server "
    ami = var.Image
    instance_type = var.Inst_type == "prod" ? "t3.small" : "t3.micro"
    vpc_security_group_ids = [aws_security_group.Allowall.id]
    tags =  var.Instanames[count.index]
    
}