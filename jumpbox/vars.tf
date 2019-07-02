variable "region" {
  description = "Region for jumpbox."
  type        = string
}

variable "image" {
  description = "Image to use for jumpbox."
  type        = string
}

variable "size" {
  description = "Size for the jumpbox."
  type        = string
}

variable "ssh_keys" {
  description = "SSH keys to put on jumpbox"
  type        = list(string)
}
