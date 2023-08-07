locals {
  key_vault_name         = format("akv-%s", var.rg_name)
  storage_account_name   = format("asa%s", replace(replace(var.rg_name, "-", ""), "_", ""))
  aks_cluster_name       = format("aks-%s", var.rg_name)
  postgresql_server_name = format("apfs-%s", var.rg_name)

  postgresql_allowed_aks = var.aks_enable == true ? { format(local.aks_cluster_name) = format("%s/%s", data.azurerm_public_ip.aks_public_ip[0].ip_address, 32) } : {}

  allowed_cidrs = var.aks_enable == true ? merge(var.postgresql_allowed_cidrs, local.postgresql_allowed_aks) : local.postgresql_allowed_aks

}

resource "random_password" "postgresql_administrator_password" {
  count   = var.postgresql_flexible_server_enable == true ? 1 : 0
  length  = 32
  special = false
}

module "create_resource_group" {
  source      = "git::https://github.com/tf-init-nxp/tf_az_resource_group.git?ref=v0.1"
  rg_name     = var.rg_name
  rg_location = var.rg_location
  rg_tags     = var.tags
}

module "create_key_vault" {
  count               = var.keyvault_enable == true ? 1 : 0
  source              = "git::https://github.com/tf-init-nxp/tf_az_key_vault.git?ref=v0.1"
  resource_group_name = module.create_resource_group.rg_name
  location            = var.rg_location
  key_vault_name      = local.key_vault_name
  tags                = var.tags
  access_policies     = var.key_vault_access_policies
  depends_on          = [module.create_resource_group]

}

module "create_storage_account" {
  count                = var.storage_account_enable == true ? 1 : 0
  source               = "git::https://github.com/tf-init-nxp/tf_az_storage_account.git?ref=v0.1"
  storage_account_name = local.storage_account_name
  resource_group_name  = module.create_resource_group.rg_name
  location             = var.rg_location

}

module "create_aks" {
  count                   = var.aks_enable == true ? 1 : 0
  source                  = "git::https://github.com/tf-init-nxp/tf_az_kubernetes_cluster.git?ref=v0.1"
  aks_cluster_name        = local.aks_cluster_name
  aks_cluster_location    = var.rg_location
  aks_resource_group_name = module.create_resource_group.rg_name

}

data "azurerm_public_ip" "aks_public_ip" {
  count               = var.aks_enable == true ? 1 : 0
  name                = module.create_aks[0].outbound_ip
  resource_group_name = module.create_aks[0].node_resource_group
}

module "create_postgresql" {
  count                  = var.postgresql_flexible_server_enable == true ? 1 : 0
  source                 = "git::https://github.com/tf-init-nxp/tf_az_postgresql_flexible_server.git?ref=v0.1"
  resource_group_name    = module.create_resource_group.rg_name
  location               = var.rg_location
  extra_tags             = var.tags
  postgresql_server_name = local.postgresql_server_name
  administrator_password = random_password.postgresql_administrator_password[0].result
  administrator_login    = var.postgresql_administrator_login
  databases              = var.postgresql_databases
  allowed_cidrs          = local.allowed_cidrs
}

resource "azurerm_key_vault_secret" "key_vault" {
  count        = var.keyvault_enable == true && var.postgresql_flexible_server_enable == true ? 1 : 0
  name         = module.create_postgresql[0].postgresql_flexible_server_name
  value        = random_password.postgresql_administrator_password[0].result
  key_vault_id = module.create_key_vault[0].key_vault_id
}
