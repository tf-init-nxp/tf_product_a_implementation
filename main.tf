locals {
  resource_group_name  = "sre-dev-001"
  storage_account_name = trim(local.resource_group_name, "-")

}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}


module "create_storage_account_imp" {
  source = "git::https://github.com/tf-init-nxp/tf_az_storage_account.git?ref=main"

  resource_group_name  = local.resource_group_name
  storage_account_name = format("storageaccount%s", "${random_string.random.result}")

}

#trigger