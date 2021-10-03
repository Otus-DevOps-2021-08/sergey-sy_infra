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

module "db" {
  source           = "../modules/db"
  db_name          = var.db_name
  public_key_path  = var.public_key_path
  db_disk_image    = var.db_disk_image
  subnet_id        = var.subnet_id
  private_key_path = var.private_key_path
}

module "app" {
  source           = "../modules/app"
  count_resources  = var.count_resources
  public_key_path  = var.public_key_path
  app_disk_image   = var.app_disk_image
  subnet_id        = var.subnet_id
  private_key_path = var.private_key_path
  database_url     = module.db.local_ip_address_db
}

