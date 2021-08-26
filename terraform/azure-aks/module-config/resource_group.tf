resource "azurerm_resource_group" "aks" {
  name     = local.aks_resource_group_name
  location = var.azure_location
  tags     = {
    "project"    = var.project,
    "env"        = var.env,
    "customer"   = var.customer,
    "cycloid.io" = "true",
  }
}