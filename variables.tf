variable "azure_subscription_id" {
  type = string
}
variable "azure_tenant_id" {
  type = string
}

variable "azure_k8s_client" {
  type = string
}

variable "azure_k8s_client_secret" {
  type = string
}

variable "azure_kubernetes_admin_ssh_key" {
  type = string
  default = "ssh_keys/my_key.pub"
}

variable "k8s_vm_size" {
  type = string
  default = "Standard_D2a_v4"
}

variable "k8s_config_file_name" {
  type = string
  default = "k8s_cluster_config"
}

variable "acr_list" {
  type = list(string)
}

variable "wp_domain" {
  type = string
}

variable "database_server_prefix" {
  type = string
}

variable "database_admin_username" {
  type = string
}

variable "database_admin_password" {
  type = string
}

variable "database_username" {
  type = string
}

variable "database_password" {
  type = string
}

variable "database_allowed_ips" {
  type = list(string)
}

variable "azure_shared_storage_key" {
  type = string
}