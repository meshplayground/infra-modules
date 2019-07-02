output "public-ip" {
  value = digitalocean_droplet.jumpbox.ipv4_address
}

output "private-ip" {
  value = digitalocean_droplet.jumpbox.ipv4_address_private
}
