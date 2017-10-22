resource "azurerm_container_service" "default" {
  name                   = "${var.namespace}-${var.k8s_cluster_name}"
  location               = "${var.location}"
  resource_group_name    = "${azurerm_resource_group.default.name}"
  orchestration_platform = "Kubernetes"

  master_profile {
    count = 1
    dns_prefix = "${var.namespace}-${var.k8s_cluster_name}"
  }

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = "${file("${var.ssh_key_public}")}"
    }
  }

  agent_pool_profile {
    name       = "${var.namespace}"
    count      = 1
    dns_prefix = "${var.namespace}-${var.k8s_cluster_name}-agent"
    vm_size    = "Standard_A0"
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }

  diagnostics_profile {
    enabled = false
  }

  tags {
    Environment = "dev"
  }

  # Get kubernetes config and save to files which can be added to remote state
  provisioner "local-exec" {
    command = "./fetch_k8s_config.sh ${lookup(azurerm_container_service.default.master_profile[0],"fqdn")} ${var.ssh_key_private}"
  }
}
