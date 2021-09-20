terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.52"
    }
  }
}

provider "google" {
  project = "k8s-fundamentals-323621"
  region  = "us-central1"
  zone    = "us-central1-a"
}

provider "google" {
  project = "k8s-fundamentals-323621"
  region  = "us-west1"
  zone    = "us-west1-a"
  alias   = "west"
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "n1-standard-1"
  #zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  #metadata_startup_script = "echo hi > /test.txt"

  //   service_account {
  //     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
  //     email  = google_service_account.default.email
  //     scopes = ["cloud-platform"]
  //   }
}

resource "google_compute_instance" "default-west" {
  name         = "test-west"
  machine_type = "n1-standard-1"
  #zone         = "us-central1-a"
  provider = google.west

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  #metadata_startup_script = "echo hi > /test.txt"

  //   service_account {
  //     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
  //     email  = google_service_account.default.email
  //     scopes = ["cloud-platform"]
  //   }
}
