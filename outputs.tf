
output "ip" {
  value = google_compute_instance.vmc_postgres_dev.network_interface.0.access_config.0.nat_ip
}
output "port" {
  value = var.port
}
output "username" {
  value = var.username
}
output "password" {
  value = var.password
}
output "dbname" {
  value = var.dbname
}