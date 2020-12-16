data "digitalocean_domain" "demo_domain" {
  name = var.demo_domain
}

resource "digitalocean_record" "auth" {
  domain = data.digitalocean_domain.demo_domain.name
  type   = "A"
  name   = "auth.demo"
  value  = digitalocean_droplet.auth.ipv4_address
}

resource "digitalocean_record" "plugins" {
  domain = data.digitalocean_domain.demo_domain.name
  type   = "A"
  name   = "plugins.demo"
  value  = digitalocean_droplet.plugins.ipv4_address
}

resource "digitalocean_record" "web01" {
  domain = data.digitalocean_domain.demo_domain.name
  type   = "A"
  name   = "web01.demo"
  value  = digitalocean_droplet.web01.ipv4_address
}

resource "digitalocean_record" "db01" {
  domain = data.digitalocean_domain.demo_domain.name
  type   = "A"
  name   = "db01.demo"
  value  = digitalocean_droplet.db01.ipv4_address
}