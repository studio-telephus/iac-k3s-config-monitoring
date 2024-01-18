provider "kubernetes" {
  host                   = module.k3s_provider_config.data.host_int
  client_certificate     = base64decode(module.k3s_provider_config.data.client_certificate)
  client_key             = base64decode(module.k3s_provider_config.data.client_key)
  cluster_ca_certificate = base64decode(module.k3s_provider_config.data.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = module.k3s_provider_config.data.host_int
    client_certificate     = base64decode(module.k3s_provider_config.data.client_certificate)
    client_key             = base64decode(module.k3s_provider_config.data.client_key)
    cluster_ca_certificate = base64decode(module.k3s_provider_config.data.cluster_ca_certificate)
  }
}
