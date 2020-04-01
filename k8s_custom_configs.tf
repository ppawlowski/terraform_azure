resource "local_file" "k8s_cluster_config" {
  filename = var.k8s_config_file_name
  sensitive_content = azurerm_kubernetes_cluster.cluster.kube_config_raw
}

resource "null_resource" "k8s_cert_manager" {
  triggers = {
    cert_manager = filemd5("k8s_custom_configs/cert-manager.yaml")
  }
  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig ${var.k8s_config_file_name} -f k8s_custom_configs/cert-manager.yaml --validate=false"
  }
  depends_on = [local_file.k8s_cluster_config]
}

resource "null_resource" "wp_ssl_certificate" {
  triggers = {
    ssl_config = filemd5("k8s_custom_configs/wp-ssl-config.yaml")
  }
  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig ${var.k8s_config_file_name} -f k8s_custom_configs/wp-ssl-config.yaml"
  }
  depends_on = [local_file.k8s_cluster_config]
}

resource "null_resource" "ingress_configuration" {
  triggers = {
    ingress_config = filemd5("k8s_custom_configs/ingress_config.yaml")
  }
  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig ${var.k8s_config_file_name} -f k8s_custom_configs/ingress_config.yaml"
  }
  depends_on = [local_file.k8s_cluster_config]
}