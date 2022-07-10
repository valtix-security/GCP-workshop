###################################
# Providers
###################################
terraform {
  required_providers {
    valtix = {
      source = "valtix-security/valtix"
    }
  }
}

provider "valtix" {
  api_key_file = file(var.valtix_api_key_file)
}

provider "google" {
  credentials = file(var.gcp_key_file)
  project     = var.gcp_project_id
  region      = var.region
}

