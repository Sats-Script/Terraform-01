locals {
    Domain = "heyitsmine.store"
    zone = "Z1004062N02GDAM5LCC1"
    instatype = var.instances == "mysql" ? "t3.small" : "t2.micro" 
    #count.index wont work here
}