provider "google" {
  version     = "3.5.0"
  credentials = file("~/.credentials/gcp-personal.json")
  project     = var.project
  region      = var.region
  zone        = "${var.region}-a"
}