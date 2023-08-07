variable "rg_location" {
  type        = string
  default     = "westeurope"
  description = "Region where resource will be created"
}

variable "rg_name" {
  type        = string
  description = "Resource group name that will be created"
}

variable "tags" {
  description = "A mapping of tags which should be assigned to all resources"
  type        = map(any)
  default     = {}
}

variable "key_vault_access_policies" {
  description = "List of access policies for the Key Vault."
  default     = []
}

variable "product" {
  type        = string
  default     = "empty"
  description = "Product to which this resource belongs"
}

variable "postgresql_databases" {
  description = <<EOF
  Map of databases configurations with database name as key and following available configuration option:
   *  (optional) charset: Valid PostgreSQL charset : https://www.postgresql.org/docs/current/multibyte.html#CHARSET-TABLE
   *  (optional) collation: Valid PostgreSQL collation : http://www.postgresql.cn/docs/13/collation.html - be careful about https://docs.microsoft.com/en-us/windows/win32/intl/locale-names?redirectedfrom=MSDN
  EOF
  type = map(object({
    charset   = optional(string, "UTF8")
    collation = optional(string, "en_US.UTF8")
  }))

}

variable "postgresql_administrator_login" {
  description = "PostgreSQL administrator login."
  type        = string
  default     = "postgresql"
}

variable "postgresql_allowed_cidrs" {
  description = "Map of authorized cidrs."
  type        = map(string)
}

variable "aks_enable" {
  description = "Enable AKS Creation"
  type        = bool
  default     = true
}


variable "keyvault_enable" {
  description = "Enable KeyVault Creation"
  type        = bool
  default     = true
}

variable "postgresql_flexible_server_enable" {
  description = "Enable Postgresql Flexible Server Creation"
  type        = bool
  default     = true
}

variable "storage_account_enable" {
  description = "Enable Storage Account Creation"
  type        = bool
  default     = true
}


#########
# kured
#########

variable "kured_chart_version" {
  description = "Version of kured to be installed"
  type        = string
}
