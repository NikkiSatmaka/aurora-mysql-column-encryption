variable "master_username" {
  description = "Aurora MySQL Master Username"
  type        = string
  sensitive   = true
}

variable "master_password" {
  description = "Aurora MySQL Master Password"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "Aurora MySQL Database Name"
  type        = string
  default     = "test_db"
}
