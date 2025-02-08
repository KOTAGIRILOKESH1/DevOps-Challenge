variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "aks-resource-group"
}
variable "location" {
  description = "Azure Region"
  type        = string
  default     = "East US"
}

variable "virtual_network_name" {
  description = "Name of the Virtual network"
  type        = string
  default     = "demo=vnet"
}

variable "subnetone" {
  description = "Name of the subnet1"
  type        = string
  default     = "subnet1 name"
}
variable "subnettwo" {
  description = "Name of the subnet2"
  type        = string
  default     = "subnet2 name"
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "my-aks-cluster"
}
 
variable "aks_node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}