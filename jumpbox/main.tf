terraform {
  required_version = ">= 0.12.3"
}

provider "digitalocean" {
    version = "~> 1.4.0"
}

resource "digitalocean_project" "terraplayground" {
  name        = "terraplayground"
  description = "A project for playing with terraform"
  purpose     = "Sandbox space for terraform testing"
  environment = "Development"
  resources   = ["${digitalocean_droplet.jumpbox.urn}"]
}

resource "digitalocean_droplet" "jumpbox" {
  image  = var.image
  name   = "${var.region}-jumpbox-01"
  region = var.region
  size   = var.size
  private_networking = true
  ssh_keys = var.ssh_keys
  tags = ["jump"]
}

resource "digitalocean_firewall" "ssh-only" {
  name = "ssh-only"

  droplet_ids = ["${digitalocean_droplet.jumpbox.id}"]

  inbound_rule {
      protocol           = "tcp"
      port_range         = "22"
      source_addresses   = ["97.113.37.139/32", "::/0"]
  }

  outbound_rule {
      protocol                = "tcp"
      port_range              = "1-65535"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
      protocol                = "udp"
      port_range              = "1-65535"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
      protocol                = "icmp"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
  }
}
