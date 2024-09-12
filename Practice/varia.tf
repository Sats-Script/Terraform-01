variable "fropo" {
    default = 22
}

variable "topo" {
    default = 22
}

variable "dns" {
    default = "heyitsmine.store"
}

variable "proto" {
    type = string
    default = "tcp"
}

variable "instances" {
    type = list(string)
    default = ["mysql" , "backend", "frontend"]
}

variable "common_tags" {
    type = map
    default = {
        Project = "Expenses"
        Environment = "DEV + PROD"
        Modules = 3
        Terraform = "true"
    }
}