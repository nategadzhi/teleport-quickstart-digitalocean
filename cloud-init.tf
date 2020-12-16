# cloud-init scripts for VMs that set things up and provision Teleport configs.
# Teleport configuration files are inline, built from templates.
# These are used in droplets.tf to bootstrap VMs.

data "template_file" "teleport-auth-cloud-init-yaml" {
  template = file("./cloud-init/teleport-auth-server.yaml")
  vars = {
    teleport_license_pem         = filebase64("./cloud-init/license.pem")
    teleport_certificate_key_pem = base64encode(acme_certificate.teleport.private_key_pem)
    teleport_certificate_pem     = base64encode("${acme_certificate.teleport.certificate_pem}${acme_certificate.teleport.issuer_pem}")
    teleport_public_addr         = var.teleport_public_addr

    # TODO cluster name should be a variable
    teleport_cluster_name  = "DemoCluster"
    teleport_cluster_token = var.teleport_cluster_token
    teleport_version       = var.teleport_version

  }

  depends_on = [acme_certificate.teleport]
}

data "template_file" "node-cloud-init-yaml" {
  template = file("./cloud-init/teleport-node.yaml")
  vars = {
    teleport_license_pem   = filebase64("./cloud-init/license.pem")
    teleport_public_addr   = var.teleport_public_addr
    teleport_cluster_token = var.teleport_cluster_token
    teleport_version       = var.teleport_version
  }
}

data "template_file" "plugins-cloud-init-yaml" {
  template = file("./cloud-init/teleport-jira.yaml")
  vars = {
    teleport_certificate_key_pem = base64encode(acme_certificate.teleport.private_key_pem)
    teleport_certificate_pem     = base64encode("${acme_certificate.teleport.certificate_pem}${acme_certificate.teleport.issuer_pem}")
    teleport_license_pem         = filebase64("./cloud-init/license.pem")
    teleport_public_addr         = var.teleport_public_addr
    plugins_public_addr          = var.plugins_public_addr
    teleport_cluster_token       = var.teleport_cluster_token
    teleport_version             = var.teleport_version
  }
}