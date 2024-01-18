output "grafana_admin_password" {
  value = "kubectl -n grafana get secret grafana -o jsonpath='{.data.admin-password}' | base64 -d; echo"
}

output "grafana_url" {
  value = "https://grafana.${local.cluster_san}"
}
