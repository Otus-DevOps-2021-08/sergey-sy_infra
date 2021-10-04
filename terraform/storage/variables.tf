variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  default = "ru-central1-a"
}
variable static_key_id {
  description = "Static key id for cloud"
}
variable static_key_secret {
  description = "Static key secret for cloud"
}
variable terraform_state_bucket {
  description = "Bucket name for terraform state"
}
