terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}
resource "random_id" "instance_id" {
  byte_length = 8
}

resource "google_compute_instance" "vmc_postgres_dev" {
  name                    = "terraform-instance-${random_id.instance_id.hex}"
  machine_type            = "f1-micro"
  tags                    = ["vgteam", "database", "postgres-13", "sql", "alpine"]
  metadata_startup_script = "echo '${file("db-dev.sql")}' > /tmp/db-dev.sql; docker run --name postgres-dev -d -p ${var.port}:5432/tcp -p ${var.port}:5432/udp -v /tmp/db-dev.sql:/tmp/db-dev.sql -e POSTGRES_USER=${var.username} -e POSTGRES_PASSWORD=${var.password} -e POSTGRES_DB=${var.dbname} postgres:13-alpine && sleep 1s && docker exec -d postgres-dev psql -U ${var.username} -d ${var.dbname} -f /tmp/db-dev.sql"
  metadata = {
    "ssh-keys" = "${var.ssh_key.user}:${file(var.ssh_key.public)}"
  }

  boot_disk {
    initialize_params {
      type  = "pd-ssd"
      size  = 10
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

resource "google_compute_firewall" "default" {
  name    = "postgres-sql"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["${var.port}"]
  }
  allow {
    protocol = "udp"
    ports    = ["${var.port}"]
  }
}

/*

docker run --name postgres-dev -p 5432:5432/tcp -p 5432:5432/udp -v /tmp/db-dev.sql:/tmp/db-dev.sql -e POSTGRES_PASSWORD=admin -d postgres:13-alpine;
docker exec -d postgres-dev psql -U postgres -f /tmp/db-dev.sql
docker rm -f $(docker ps -aq)

docker rm -f $(docker ps -aq); docker run --name postgres-dev -p 5432:5432/tcp -p 5432:5432/udp -v /tmp/db-dev.sql:/tmp/db-dev.sql -e POSTGRES_PASSWORD=admin -d postgres:13-alpine && sleep 1s && docker exec -d postgres-dev psql -U postgres -f /tmp/db-dev.sql

*/
