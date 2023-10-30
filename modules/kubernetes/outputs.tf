output "k8s_identity_object_id" {
  value = data.azurerm_kubernetes_cluster.kubelet_identity.kubelet_identity[0].object_id
}