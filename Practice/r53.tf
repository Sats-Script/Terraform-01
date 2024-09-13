resource "aws_route53_record" "pract" {

  count   = length(var.instances)
  zone_id = local.zone
  name    = var.instances[count.index] == "frontend" ? local.Domain: "${var.instances[count.index]}.${local.Domain}"
  type    = "A"
  ttl     = "1"
  records = var.instances[count.index] == "frontend" ? [aws_instance.practical[count.index].public_ip] : [aws_instance.practical[count.index].private_ip]
}