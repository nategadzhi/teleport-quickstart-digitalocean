terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    acme = {
      source = "vancluever/acme"
    }
    template = {
      source = "hashicorp/template"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
  required_version = ">= 0.13"
}

provider "digitalocean" {
  token = var.do_token
}
