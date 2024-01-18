locals {
  cluster_domain = "cluster.local"
  cluster_san    = "k3s.${var.env}.acme.corp"
}
