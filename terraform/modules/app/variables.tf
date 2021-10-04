variable count_resources {
  description = "Count of application instances"
  default     = 1
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "fd8jn6bdqnuo2ro7d2rm"
}
variable subnet_id {
  description = "Subnets for modules"
}
variable database_url {
  description = "Database url for reddit app"
}
variable private_key_path {
  description = "Private key path for conneaction to  app server"
}

