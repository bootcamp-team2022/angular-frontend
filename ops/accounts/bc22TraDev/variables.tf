variable "environment" {
  type = string
}

variable "volume_size" {
  type = string
}

variable "db_user" {
  description = "Database admin username"
  type        = string
  sensitive   = true
}

variable "db_pass" {
  description = "Database password"
  type        = string
  sensitive   = true
}