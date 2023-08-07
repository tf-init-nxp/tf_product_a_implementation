provider "helm" {

  kubernetes {
    host = var.aks_enable == true ? module.create_aks[0].host : 0
    client_certificate     = var.aks_enable == true ? base64decode(module.create_aks[0].client_certificate) : 0
    client_key             = var.aks_enable == true ? base64decode(module.create_aks[0].client_key) : 0
    cluster_ca_certificate = var.aks_enable == true ? base64decode(module.create_aks[0].cluster_ca_certificate) : 0
  }
}

module "kured" {
  count                  = var.aks_enable == true ? 1 : 0
  source                 = "git::https://github.com/tf-init-nxp/tf_kured.git?ref=v0.1"
  kured_chart_version    = var.kured_chart_version
}
