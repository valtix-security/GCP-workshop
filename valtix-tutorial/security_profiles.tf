#### IPS/IDS Security Profile ####
resource "valtix_profile_network_intrusion" "balanced_alert" {
  name = "gcp-workshop-balanced-alert"
  action = "Allow Log"
  policy = "BALANCED"
  policy_action = "NONE"
  auto_update = true
  delay_by_days = 0
}

#### DLP Security Profile ####
resource "valtix_profile_dlp" "block_SSN" {
  name = "block-SSN"
  description = ""
  dlp_filter_list {
    count = 2
    action = "Deny Log"
    static_patterns = ["US Social Security Number"]
  }
}

#### URL Filtering Security Profile ####
resource "valtix_profile_urlfilter" "allow_valtix_github" {
  name = "allow-valtix-security-github"
  description = "allow only valtix-security github"
  url_filter_list {
    url_list = ["http.*github.com/valtix-security.*"]
    policy = "Allow Log"
  }
  url_filter_list {
    url_list = ["http.*github.com/.*"]
    policy = "Deny Log"
    return_status = 502
  }
  uncategorized_url_filter {
    policy = "Deny Log"
    return_status = 503
  }
  default_url_filter {
    policy = "Deny No Log"
    return_status = 503
  }
}
