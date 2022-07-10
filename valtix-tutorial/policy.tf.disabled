###################################
# 3a. Policy
###################################
resource "valtix_policy_rules" "egress_policy_rules" {
  rule_set_id = valtix_policy_rule_set.egress_rule_set.rule_set_id
  rule {
    name        = "allow_only_production"
    action      = "ALLOW_LOG"
    state       = "ENABLED"
    service     = valtix_service_object.https_service.service_id
    source      = valtix_address_object.production_ag.address_id
    destination = data.valtix_address_object.internet_ag.address_id
    type        = "ForwardProxy"
    network_intrusion_profile = valtix_profile_network_intrusion.balanced_alert.profile_id
    url_filter  = valtix_profile_urlfilter.allow_valtix_github.profile_id
    dlp_profile = valtix_profile_dlp.block_SSN.profile_id
  }
  rule {
    name = "egress-forwarding-allow"
    description = "Egress forwarding policy rule."
    action = "Allow Log"
    state = "ENABLED"
    service = 2
    source = 1
    malicious_ip_profile = 1
    packet_capture_enabled = false
    send_deny_reset = false
    fqdn_filter_profile = 1
    type = "Forwarding"
    destination = 1
  }
  rule {
    name = "egress-udp-forwarding-allow"
    description = "Egress UDP forwarding policy rule."
    action = "Allow Log"
    state = "ENABLED"
    service = 3
    source = 1
    malicious_ip_profile = 1
    packet_capture_enabled = false
    send_deny_reset = false
    fqdn_filter_profile = 1
    type = "Forwarding"
    destination = 1
  }
}

