variable "valtix_api_key_file" {}
variable "gcp_key_file" {}
variable "gcp_project_id" {}
variable "valtix_account_name" {
  default = "valtix-gcp-demo"
}
variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-c"
}
variable "prefix" {
  default = "valtix-gcp-demo"
}
variable "service_account_email" {}
variable "spoke_vpcs" {}
