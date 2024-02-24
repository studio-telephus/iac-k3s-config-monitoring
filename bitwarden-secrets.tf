locals {
  bw_k3s_provider_config_id = {
    snb = "1721d632-8ef6-4398-9fd5-b12000dfed36"
    dev = "49f8b087-1412-4e96-9361-b1200161b670"
  }
}

module "k3s_provider_config" {
  source = "github.com/studio-telephus/terraform-bitwarden-get-item-secure-note.git?ref=1.0.0"
  id     = local.bw_k3s_provider_config_id[var.env]
}
