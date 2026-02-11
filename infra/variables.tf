variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "East US"
}

variable "env" {
  type        = string
  description = "Environment Name"
  default     = "dev"
}

variable "owner" {
  type        = string
  description = "Resource Owner"
}