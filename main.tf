resource "google_compute_disk" "data" {
  project      = var.project_name
  name  	   = "data${count.index}"
  count        = var.number_of_servers
#  type  	   = "pd-ssd"
  zone         = var.zone
 # zone         = data.google_compute_zones.available.names[2]
  size         = 100
  labels = {
    environment = var.environment
  }
}

#data "google_compute_zones" "available" {}

resource "google_compute_instance" "default" {
  project      = var.project_name
  #zone         = data.google_compute_zones.available.names[2]
  zone         = var.zone
  name         = "poc-aml6${count.index}"
  allow_stopping_for_update = true
  count	       = var.number_of_servers
  machine_type = var.vm_type

  boot_disk {
    initialize_params {
      image = "centos-7-v20191210"
      size = "100"
    }
  }

#  scratch_disk {
#    interface = "SCSI"
#  }

  attached_disk {
   source      = "${google_compute_disk.data.*.self_link[count.index]}"
   mode			=  "READ_WRITE"
  }

  network_interface {
    subnetwork       = "net1"

  }

   scheduling {
      automatic_restart = "true"
   }

   metadata = {
       ssh-keys = "${var.username}:${file("${var.public_key_path}")}"
   }
}