provider "google" {
  credentials  = file("./service_account.json")
  project = "sample-1-12345"
  region  = local.region
  zone    = local.zone
}

locals {
  region = "us-central1"
  zone   = "us-central1-c"
  home_ip = "1.2.3.4"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

  network_interface {
    # A default network is created for all GCP projects
    subnetwork = google_compute_subnetwork.vpc_subnetwork.self_link
    access_config {
    }
  }

   boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  labels = {
    environment = "production"
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Valtix Sample Application</h1></body></html>' | sudo tee /var/www/html/index.html"
}

resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh-http-to-production"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "443", "80"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_route" "allow_home_ip_ssh" {
  name         = "allow-home-ip-ssh-prod"
  dest_range   = local.home_ip
  network      = google_compute_network.vpc_network.name
  next_hop_gateway = "default-internet-gateway"
}


resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "valtix-demo-production-subnet"
  ip_cidr_range = "10.1.0.0/24"
  region        = local.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_network" "vpc_network" {
  name                    = "valtix-demo-production-network"
  auto_create_subnetworks = "false"
}
