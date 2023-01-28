provider "azurerm" {
  features {}
  subscription_id = ""
  tenant_id       = ""
  client_id       = ""
  client_secret   = ""
}

resource "azurerm_resource_group" "rgvar" {
  count = length(var.loc)
  name     = "az-${var.env}-var-${count.index}"
  location = var.loc[count.index]
}

#resource "azurerm_resource_group" "rg0" {
#  count = 2
#  name     = "azdevrg12-${count.index}"
#  location = "eastus2"
#}

resource "azurerm_resource_group" "rg0" {
  name     = "azdevrg0"
  location = "eastus2"
}

resource "azurerm_storage_account" "sa0" {
  count = 2
  resource_group_name      = resource.azurerm_resource_group.rg0.name
  name                     = "azsa${count.index}"
  location                 = "eastus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_resource_group" "rg1" {
  name     = "azdevrg12"
  location = "eastus2"
}

resource "azurerm_storage_account" "sa1" {
  resource_group_name      = resource.azurerm_resource_group.rg1.name
  name                     = "azsapractice12"
  location                 = "eastus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sa_cont" {
  name                  = "azpracticecont12"
  storage_account_name  = azurerm_storage_account.sa1.name
  container_access_type = "container"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "azdevrg1"
    storage_account_name = "azsapractice"
    container_name       = "azpracticecont"
    key                  = "dev.terraform.tfstate"
    access_key           = "NO54WYOcVNicqiEl4dAyIU7VPCwfNPzdyIM051a59tjTZYs62V1ZQ7pw7N8re47heTq+994Z72LA+AStamCv0w=="
  }
}
