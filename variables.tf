# Azure RM settings
variable "location" {
  default = "West US 2"
}

variable "subscription_id" {
  description = "Subscription ID for Azure account"
}

variable "client_id" {
  description = "Client ID for Azure account"
}

variable "client_secret" {
  description = "Client secret for Azure account"
}

variable "tenant_id" {
  description = "Tennant ID for Azure account"
}

# General variables
variable "namespace" {
  default = "opendev"
}

variable "k8s_cluster_name" {
  description = "Kubernetes cluster name"
  default = "k8s"
}

variable "ssh_key_public" {
  description = "SSH Key to load to server"
  default = "~/.ssh/server_rsa.pub"
}

variable "ssh_key_private" {
  description = "SSH Key to load to server"
  default = "~/.ssh/server_rsa"
}
