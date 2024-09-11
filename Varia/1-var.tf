variable "Inst_type"  {
    type = string
    default = "dev"
}

variable "Image" {
    type = string
    default = "ami-09c813fb71547fc4f"
}

variable "tags" {
    type = map
    default = {
        Name = "backend"
        Project = "Expense"
        Environment = "DEV"
        Terraform = "true"
    }
    
}

variable "sg_name" {
    type = string
    default = "Allow_sshh"
}

variable "sg_desc" {
    # type = string
    default =  "Allows SSH connection on port nu.22"
}

variable "frompo" {
    type = number
    default = 22
}

variable "topo" {
    type = number
    default = 22
}

variable "proto" {
    default = "tcp"
}

variable "Incidr" {
    type = list(string)
    default = ["0.0.0.0/0"]

}

