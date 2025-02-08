terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # Or your preferred version
    }
  }
}
provider "azurerm" {
  features {}
}
 
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.1.0.0/16"]
}
 
resource "azurerm_subnet" "subnet1" {
  name                 = "subnetone"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.1.1.0/24"]
}
 
resource "azurerm_subnet" "subnettwo" {
  name                 = "subnettwo"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "aks-cluster"
 
  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
 
    # Ensure the subnet exists and is properly referenced
    vnet_subnet_id = azurerm_subnet.subnet1.id
  }
 
  identity {
    type = "SystemAssigned"
  }
 
  depends_on = [
    azurerm_subnet.subnet1
  ]
}