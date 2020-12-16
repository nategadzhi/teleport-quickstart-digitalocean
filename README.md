# Teleport Quick Start

This repo provides a boilerplate to quickly setup a demo Teleport cluster on
DigitalOcean using Terraform. I use it for experiments, tests, and demos for
gravitational/teleport-plugins.

This was mostly an excersize in learning how to bootstrap a Teleport cluster,
and it's not a reference setup by any means.

This repo is not maintained, supported, or endorsed by Teleport.

## What it does

It provisions the following:

- 4 DigitalOcean VMs
- Assigns DNS records to those VMs, they'll be publicly accessible. No VPC at
  this point.
- Sets up Teleport and Teleport configuration for the Auth server and the Nodes.
- Sets up TLS certificate for the Auth and the Plugins server with LetsEncrypt.

## Quick Start and Requirements

### Variables and settings

Take a look at `variables.tf`. Here's an example `terraform.tfvars`:

```HCL
do_token = "..." # DigitalOcean API token
acme_account_email = "your@email.com" # your real email address for letsencrypt

demo_domain = "your.tld" # domain to use. The VMs will be on *.demo.your.tld

teleport_public_addr = "auth.demo.your.tld"
plugins_public_addr = "plugins.demo.your.tld"
```

After you `terraform apply`, the auth VM will run Teleport Auth server, and all
other VMs will run as nodes. The `plugins` VM is intended to run teleport
plugins, but doesn't have any plugin binary preinstalled yet.

### Teleport Enterprise License

This setup is intended to test Teleport Plugins, and they all currently require
a Teleport Enterprise license to run. Put your `license.pem` into
`./cloud-init/`, and it'll automatically be setup on the VMs in the cluster.
