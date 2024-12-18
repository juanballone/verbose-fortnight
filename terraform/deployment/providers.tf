provider "azurerm" {
  use_oidc = true
  features {}
}

provider "helm" {
  kubernetes {
    host                   = module.main.host
    client_certificate     = module.main.client_certificate
    client_key             = module.main.client_key
    cluster_ca_certificate = module.main.cluster_ca_certificate
  }
}

provider "kubernetes" {
  host                   = module.main.host
  client_certificate     = module.main.client_certificate
  client_key             = module.main.client_key
  cluster_ca_certificate = module.main.cluster_ca_certificate
}
