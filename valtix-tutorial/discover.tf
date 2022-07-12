#############################################
# 1a. Setup GCP project for Onboarding
#############################################
module "csp_setup" {
  source               = "github.com/valtix-security/terraform-gcp-setup"
  gcp_credentials_file = file(var.gcp_key_file)
  prefix               = var.prefix
  project_id           = var.gcp_project_id
}

#############################################
# 1b. Onboard GCP Project to Valtix
#############################################
resource "valtix_cloud_account" "gcp_demo" {
  name                 = var.valtix_account_name
  csp_type             = "GCP"
  gcp_credentials_file = module.csp_setup.private_key_file_content
  inventory_monitoring {
    regions          = [var.region]
    refresh_interval = 60
  }
  depends_on = [module.csp_setup]
}
