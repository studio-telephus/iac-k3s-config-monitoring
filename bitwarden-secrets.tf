locals {
  bw_k3s_provider_config_id = {
    dev = "44ce16d0-c7cd-43fa-ba7a-b0f800b6a7c4"
  }
}

module "k3s_provider_config" {
  source = "github.com/studio-telephus/terraform-bitwarden-get-item-secure-note.git?ref=1.0.0"
  id     = local.bw_k3s_provider_config_id[var.env]
}
