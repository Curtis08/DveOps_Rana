
variable "security_rule" {
 type = list(object({
  name                     = string
  resource_group_name      = string
  location                 = string
  account_tier             = string
  account_replication_type = string
  }))
}
  

