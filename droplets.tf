data "digitalocean_ssh_key" "demo" {
  name = var.demo_ssh_key_name
}

resource "digitalocean_droplet" "auth" {
  image      = "ubuntu-20-04-x64"
  name       = "auth.demo.${var.demo_domain}"
  region     = var.droplet_region
  size       = var.droplet_size
  ssh_keys   = [data.digitalocean_ssh_key.demo.id]
  user_data  = data.template_file.teleport-auth-cloud-init-yaml.rendered
  depends_on = [acme_certificate.teleport]
}

resource "digitalocean_droplet" "plugins" {
  image      = "ubuntu-20-04-x64"
  name       = "plugins.demo.${var.demo_domain}"
  region     = var.droplet_region
  size       = var.droplet_size
  ssh_keys   = [data.digitalocean_ssh_key.demo.id]
  user_data  = data.template_file.plugins-cloud-init-yaml.rendered
  depends_on = [acme_certificate.teleport]
}

resource "digitalocean_droplet" "web01" {
  image      = "ubuntu-20-04-x64"
  name       = "web01.demo.${var.demo_domain}"
  region     = var.droplet_region
  size       = var.droplet_size
  ssh_keys   = [data.digitalocean_ssh_key.demo.id]
  user_data  = data.template_file.node-cloud-init-yaml.rendered
  depends_on = [acme_certificate.teleport]
}

resource "digitalocean_droplet" "db01" {
  image      = "ubuntu-20-04-x64"
  name       = "db01.demo.${var.demo_domain}"
  region     = var.droplet_region
  size       = var.droplet_size
  ssh_keys   = [data.digitalocean_ssh_key.demo.id]
  user_data  = data.template_file.node-cloud-init-yaml.rendered
  depends_on = [acme_certificate.teleport]
}