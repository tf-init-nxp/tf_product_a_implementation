# tf_storage_account_rs

<!-- BEGIN_TF_DOCS -->
# Terraform Module to create AZ Resources

## Contributing
If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

## Usage


## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| random | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| create\_aks | git::https://github.com/tf-init-nxp/tf_az_kubernetes_cluster.git | v0.1 |
| create\_key\_vault | git::https://github.com/tf-init-nxp/tf_az_key_vault.git | v0.1 |
| create\_postgresql | git::https://github.com/tf-init-nxp/tf_az_postgresql_flexible_server.git | v0.1 |
| create\_resource\_group | git::https://github.com/tf-init-nxp/tf_az_resource_group.git | v0.1 |
| create\_storage\_account | git::https://github.com/tf-init-nxp/tf_az_storage_account.git | v0.1 |
| ingres\_nginx | git::https://github.com/tf-init-nxp/tf_ingress_nginx.git | main |
| kured | git::https://github.com/tf-init-nxp/tf_kured.git | v0.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [random_password.postgresql_administrator_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_public_ip.aks_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aks\_enable | Enable AKS Creation | `bool` | `true` | no |
| ingres\_nginx\_additional\_set | Optional set for additional helm settings | <pre>set(<br>    object(<br>      {<br>        name  = string<br>        value = string<br>        type  = optional(string)<br>      }<br>    )<br>  )</pre> | `[]` | no |
| ingres\_nginx\_chart\_version | Version of ingres NGINX to be installed | `string` | n/a | yes |
| key\_vault\_access\_policies | List of access policies for the Key Vault. | `any` | `[]` | no |
| keyvault\_enable | Enable KeyVault Creation | `bool` | `true` | no |
| kured\_chart\_version | Version of kured to be installed | `string` | n/a | yes |
| postgresql\_administrator\_login | PostgreSQL administrator login. | `string` | `"postgresql"` | no |
| postgresql\_allowed\_cidrs | Map of authorized cidrs. | `map(string)` | n/a | yes |
| postgresql\_databases | Map of databases configurations with database name as key and following available configuration option:<br>   *  (optional) charset: Valid PostgreSQL charset : https://www.postgresql.org/docs/current/multibyte.html#CHARSET-TABLE<br>   *  (optional) collation: Valid PostgreSQL collation : http://www.postgresql.cn/docs/13/collation.html - be careful about https://docs.microsoft.com/en-us/windows/win32/intl/locale-names?redirectedfrom=MSDN | <pre>map(object({<br>    charset   = optional(string, "UTF8")<br>    collation = optional(string, "en_US.UTF8")<br>  }))</pre> | n/a | yes |
| postgresql\_flexible\_server\_enable | Enable Postgresql Flexible Server Creation | `bool` | `true` | no |
| rg\_location | Region where resource will be created | `string` | `"westeurope"` | no |
| rg\_name | Resource group name that will be created | `string` | n/a | yes |
| storage\_account\_enable | Enable Storage Account Creation | `bool` | `true` | no |
| tags | A mapping of tags which should be assigned to all resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| aks\_client\_certificate | client\_certificate |
| aks\_client\_client\_key | client\_key |
| aks\_cluster\_ca\_certificate | cluster\_ca\_certificate |
| aks\_ip\_address | AKS Cluster IP Address |
<!-- END_TF_DOCS -->
