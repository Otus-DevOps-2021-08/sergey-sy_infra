variable count_resources {
  description = "Count of application instances"
  default     = 1
}
variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable default_zone {
  description = "Default zone for instance"
  default     = "ru-central1-a"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  description = "Pat to the private key used for ssh access"
}
variable subnet_id {
  description = "Subnet"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
variable db_name {
  description = "Name for db instance"
}

