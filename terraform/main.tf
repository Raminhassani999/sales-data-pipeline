terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6"
    }
  }
}

provider "docker" {}

resource "docker_network" "sales_network" {
  name = "sales-network"
}

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