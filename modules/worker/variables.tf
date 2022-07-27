variable "hostname_prefix" {
    type = string
    default = "mkeworker-"
}

variable "worker_count" {
  type    = number
  default = 1
}

variable "worker_volume_size" {
  type    = string
  default = "30"
}

variable security_group_id {
  type = string
}

variable subnet_id {
  type = string
}

variable "nodeami" {
  type    = string
  default = "ami-0c1a7f89451184c8b"  //Ubuntu-20.04
}

variable "instancetype" {
  type    = string
  default = "t2.micro"
}

variable "sshkeypair" {
  type    = string
}

variable "DOCKER_EE_VERSION" {
  type = string
}