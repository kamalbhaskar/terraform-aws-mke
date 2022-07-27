variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "profile" {
  type    = string
  default = "default"
}

variable "public_key" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "node_subnet_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

# variable subnet_az {
#     type = string
#     default = "ap-south-1b"
# }