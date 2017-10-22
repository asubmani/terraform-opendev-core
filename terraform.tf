terraform {
  backend "azurerm" {
    storage_account_name = "nictfremotestate"
    container_name       = "opendev"
    key                  = "core.terraform.tfstate"
  }
}

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}
