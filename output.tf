output "k8s_master_dns" {
  value = "${lookup(azurerm_container_service.default.master_profile[0],"fqdn")}"
}

output "k8s_cluster_ca_cert" {
  value = "${file("./cluster-ca-cert.pem")}"
 
  depends_on = ["${azurerm_container_service.default}"]
  sensitive  = true
}

output "k8s_client_cert" {
  value = "${file("./client-cert.pem")}"
 
  depends_on = ["${azurerm_container_service.default}"]
  sensitive  = true
}

output "k8s_client_key" {
  value = "${file("./client-key.pem")}"
  
  depends_on = ["${azurerm_container_service.default}"]
  sensitive  = true
}
