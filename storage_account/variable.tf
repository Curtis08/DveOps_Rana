variable "storage_account_name" {
    type = string
    default = null

}

variable "resource_group.name" {
    type = string
    default = null

}

variable "location" {
    type = string
    default = null

}

variable "account_tier" {
    type = string
    default = null

}

variable "account_replication_type" {
    type = string
    default = null

}

variable "tags" {
    type = string
    default = "staging"

}
