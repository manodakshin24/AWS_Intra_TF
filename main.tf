terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "project-bad2bf27-d410-468a-acf"
  region  = "us-east1"
}

# ---------------------------
# GCS Buckets (S3 equivalents)
# ---------------------------

resource "google_storage_bucket" "static_website" {
  uniform_bucket_level_access = true
  name          = "my-first-bucket-from-terraform-mdak-2026"
  location      = "US"
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "error.html"
  }

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket" "devops_bucket" {
  uniform_bucket_level_access = true
  name          = "mano-test-bucket-1-mdak-2026"
  location      = "US"
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "error.html"
  }
}

resource "google_storage_bucket" "delete_later" {
  uniform_bucket_level_access = true
  name          = "will-delete-later-mdak-2026"
  location      = "US"
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "error.html"
  }
}

resource "google_storage_bucket" "devops_bucket_1" {
  uniform_bucket_level_access = true
  name          = "mano-test-bucket1234-mdak-2026"
  location      = "US"
  force_destroy = true

  labels = {
    env     = "dev"
    service = "s3"
    team    = "devops"
  }

  versioning {
    enabled = true
  }
}

# ---------------------------
# GCS Object (folder creation)
# ---------------------------

resource "google_storage_bucket_object" "mano_folder" {
  name   = "Mano/dakshin/"   # GCS treats this as a folder prefix
  bucket = google_storage_bucket.devops_bucket_1.name
  content = "folder-marker"               # GCS requires content for objects
}

# ---------------------------
# Compute Engine VM (EC2 equivalent)
# ---------------------------

resource "google_compute_instance" "example_vm" {
  name         = "mdak-instance"
  machine_type = "e2-micro"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  labels = {
    name = "mdak"
  }
}
