data "aws_ami" "pradata" {
  most_recent = true
  owners      = [973714476881]

  filter {
    name = "name"
    values = ["RHEL-9-DevOps-Practice"]
}
}

# "ami-09c813fb71547fc4f"Publish date: 2024-08-31