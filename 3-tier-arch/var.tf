variable "instances" {

    type = list(string)
    default = ["mysql", "backend", "frontend"]
}

variable "common_tags" {
    type = map
    default = {
        Project_name = "Expense"
        Environment = "Dev"
        Terraform = "True"
    }
}

variable "zone_id" {

    default = "Z1004062N02GDAM5LCC1"
}

variable "domain_name" {

    default = "heyitsmine.store"
}
