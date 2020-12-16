# Provide your own Digital Ocean API token
variable "do_token" {}

# TLS provider settings
variable "acme_server_url" {
  default = "https://acme-v02.api.letsencrypt.org/directory"
}

# Your LetsEncrypt account email
variable "acme_account_email" {}

# Domain name to use for the demo.
# Instances are going to be mapped as
# {instancename}.demo.tld
variable "demo_domain" { default = "respawn.engineering" }

# An SSH key name on your digital ocean account.
# TODO: explicitly use public key file instead.
variable "demo_ssh_key_name" {
  default = "Personal"
}

# What region to run instances in
variable "droplet_region" {
  default = "sfo2"
}

variable "droplet_size" {
  default = "s-2vcpu-4gb"
}

# Teleport configuration. See cloud-init.tf.
# Domain names here must match var.demo_domain.
variable "teleport_cluster_token" { default = "yolo-token" }
variable "teleport_public_addr" { default = "auth.demo.respawn.engineering" }
variable "plugins_public_addr" { default = "plugins.demo.respawn.engineering" }
variable "teleport_version" { default = "v5.0.2" }