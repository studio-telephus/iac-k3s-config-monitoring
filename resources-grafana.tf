resource "kubernetes_namespace" "grafana" {
  metadata {
    name = "grafana"
  }
}

resource "helm_release" "grafana" {
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  version          = "7.0.21"
  namespace        = "grafana"
  create_namespace = "false"
  timeout          = "600"

  set {
    name  = "deploymentStrategy.type"
    value = "Recreate"
  }
  set {
    name  = "persistence.enabled"
    value = "true"
  }

  values = [
    <<-EOT
    ingress:
      enabled: true
      className: traefik
      hosts:
      - grafana.${local.cluster_san}
      tls:
      - secretName: grafana-tls
        hosts:
        - grafana.${local.cluster_san}
      annotations:
        cert-manager.io/cluster-issuer: "cm-cluster-issuer"

    datasources:
      datasources.yaml:
        apiVersion: 1
        datasources:
        - name: Prometheus
          type: prometheus
          url: http://prometheus-server.prometheus.svc.${local.cluster_domain}
          access: proxy
          isDefault: true
        - name: Loki
          type: loki
          url: http://loki.loki.svc.${local.cluster_domain}:3100

    dashboardProviders:
      dashboardproviders.yaml:
        apiVersion: 1
        providers:
        - name: 'default'
          orgId: 1
          folder: ''
          type: file
          disableDeletion: false
          editable: true
          options:
            path: /var/lib/grafana/dashboards/default
    dashboards:
      default:
        node-exporter:
          gnetId: 1860
          revision: 27
        ingress-controller:
          url: https://raw.githubusercontent.com/swisscom/terraform-dcs-kubernetes/master/deployments/dashboards/ingress-controller.json
          token: ''
    EOT
  ]

  depends_on = [
    kubernetes_namespace.grafana,
    helm_release.prometheus
  ]
}
