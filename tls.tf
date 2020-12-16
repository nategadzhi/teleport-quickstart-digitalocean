provider "acme" {
  server_url = var.acme_server_url
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.acme_account_email
}

resource "acme_certificate" "teleport" {
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = var.teleport_public_addr
  subject_alternative_names = [var.plugins_public_addr]

  dns_challenge {
    provider = "digitalocean"

    config = {
      DO_AUTH_TOKEN = var.do_token
    }
  }
}