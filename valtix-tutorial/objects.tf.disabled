#### Internet Address Objects ####
data "valtix_address_object" "internet_ag" {
  name = "internet"
}

#### User Define Tag Address Objects ####
resource "valtix_address_object" "production_ag" {
  name        = "production"
  description = "Dynamic User Defined Tag"
  type        = "DYNAMIC_USER_DEFINED_TAG"
  tag_list {
      tag_key       = "environment"
      tag_value     = "production"
      resource_type = "RESOURCE_INSTANCE"
  }
}

#### HTTPS Service Object ####
resource "valtix_service_object" "https_service" {
  name = "https-service"
  description = "HTTPS forward proxy."
  service_type = "ForwardProxy"
  protocol = "TCP"
  source_nat = false
  tls_profile = 2
  transport_mode = "HTTPS"
        port {
                destination_ports = "443"
        }
}
