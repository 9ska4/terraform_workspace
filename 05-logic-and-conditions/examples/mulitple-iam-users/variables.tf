variable "user_name_prefix" {
  description = "The prefix to use for the user name"
  type        = string
  default     = "tom"
}

variable "user_names_list" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}
