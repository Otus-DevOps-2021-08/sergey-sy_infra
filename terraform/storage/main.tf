variable "YC_SERVICE_ACCOUNT_TERRAFORM_KEY_FILE" {
  # set the environment variable export TF_VAR_YC_SERVICE_ACCOUNT_TERRAFORM_KEY_FILE="/path/example/yandex-cloud-key.json"
  type = string
}

provider "yandex" {
  service_account_key_file = var.YC_SERVICE_ACCOUNT_TERRAFORM_KEY_FILE
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_storage_bucket" "terraform_state_bucket" {
  access_key = var.static_key_id
  secret_key = var.static_key_secret
  bucket = var.terraform_state_bucket
}

