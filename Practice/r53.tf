resource "aws_route53_record" "pract" {

   count = length(var.instances)
   zone_id = "Z1004062N02GDAM5LCC1" 
   name = "${var.instances[count.index]}.${var.dns}"
   type = "A"
   ttl = "1"
   records = [aws_instance.practical[count.index].private_ip]
}