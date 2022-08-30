variable "bc22_vpc_cidr" {
  type = string
}

variable "bc22_subnet_cidr" {
  type = map(any)
}

variable "bc22_az" {
  type = map(any)
}

variable "environment" {
  type = string
}