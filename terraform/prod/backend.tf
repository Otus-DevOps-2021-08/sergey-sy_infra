terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "trfm-stt-bckt"
    region   = "us-east-1"
    key      = "terraform-storage-prod/terraform.tfstate"
    #  access_key = Set this value interactivly while terraform init. Also command available in README.  https://www.terraform.io/docs/language/settings/backends/configuration.html#partial-configuration
    #  secret_key = Set this value interactivly while terraform init. Also command available in README.  https://www.terraform.io/docs/language/settings/backends/configuration.html#partial-configuration

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

