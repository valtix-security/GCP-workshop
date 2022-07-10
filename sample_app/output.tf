output "instance_private_ip" {
  value = google_compute_instance.vm_instance.network_interface.0.network_ip
}
output "instance_public_ip" {
  value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}
output "instance_id" {
  value = google_compute_instance.vm_instance.instance_id
}
output "sample_app_vpc_name" {
  value = "valtix-demo-production-network"
}
