terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6"
    }
  }
}

provider "docker" {}

# --------------------------------------------------
# Docker Network
# --------------------------------------------------

resource "docker_network" "sales_network" {
  name = "sales-network"
}

# --------------------------------------------------
# Sales PostgreSQL Database
# --------------------------------------------------

resource "docker_image" "postgres" {
  name = "postgres:16"
}

resource "docker_container" "postgres" {
  name  = "sales-postgres"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_DB=sales_db",
    "POSTGRES_USER=sales_user",
    "POSTGRES_PASSWORD=sales_password"
  ]

  ports {
    internal = 5432
    external = 5433
  }

  networks_advanced {
    name = docker_network.sales_network.name
  }
}

# --------------------------------------------------
# Kestra PostgreSQL Database
# --------------------------------------------------

resource "docker_image" "kestra_postgres" {
  name = "postgres:16"
}

resource "docker_container" "kestra_postgres" {
  name  = "kestra-postgres"
  image = docker_image.kestra_postgres.image_id

  env = [
    "POSTGRES_DB=kestra",
    "POSTGRES_USER=kestra",
    "POSTGRES_PASSWORD=k3str4"
  ]

  networks_advanced {
    name = docker_network.sales_network.name
  }
}

# --------------------------------------------------
# Kestra Storage
# --------------------------------------------------

resource "docker_volume" "kestra_storage" {
  name = "sales-kestra-storage"
}

# --------------------------------------------------
# Kestra
# --------------------------------------------------

resource "docker_image" "kestra" {
  name = "kestra/kestra:v1.1"
}

resource "docker_container" "kestra" {
  name  = "sales-kestra"
  image = docker_image.kestra.image_id

  # Run Kestra as root so it can access
  # the Docker socket.
  user = "root"

  command = [
    "server",
    "standalone"
  ]

  # ------------------------------------------------
  # Kestra Configuration
  # ------------------------------------------------

  env = [
    <<-EOT
    KESTRA_CONFIGURATION=datasources:
      postgres:
        url: jdbc:postgresql://kestra-postgres:5432/kestra
        driver-class-name: org.postgresql.Driver
        username: kestra
        password: k3str4
    kestra:
      repository:
        type: postgres
      queue:
        type: postgres
      storage:
        type: local
        local:
          base-path: /app/storage
      url: http://localhost:8082/
    EOT
  ]

  # ------------------------------------------------
  # Kestra Web UI
  # ------------------------------------------------

  ports {
    internal = 8080
    external = 8082
  }

  # ------------------------------------------------
  # Docker Network
  # ------------------------------------------------

  networks_advanced {
    name = docker_network.sales_network.name
  }

  # ------------------------------------------------
  # Kestra Persistent Storage
  # ------------------------------------------------

  volumes {
    volume_name    = docker_volume.kestra_storage.name
    container_path = "/app/storage"
  }

  # ------------------------------------------------
  # Docker Socket
  #
  # Allows Kestra to communicate with Docker
  # and create containers for Docker task runners.
  # ------------------------------------------------

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }

  # ------------------------------------------------
  # Temporary directory
  # ------------------------------------------------

  volumes {
    host_path      = "/tmp"
    container_path = "/tmp"
  }

  # ------------------------------------------------
  # Start Kestra after its PostgreSQL database
  # ------------------------------------------------

  depends_on = [
    docker_container.kestra_postgres
  ]
}