// Configure Google Cloud provider
provider "google" {
 credentials = file(var.gcloud_credentials)
 project     = var.gcloud_project 
 region      = var.cluster_region 
}

// core cluster
resource "google_compute_instance" "vs" {
 count        = var.number_coreserver
 name         = "${var.cluster_name}-coreserver${count.index}"
 machine_type = var.flavor_coreserver 
 zone         = var.cluster_region
 allow_stopping_for_update = true
 lifecycle {
    ignore_changes = [attached_disk]
 }

 boot_disk {
   initialize_params {
     image = var.image_coreserver 
   }
 }

 attached_disk {
  source     = "projects/${var.gcloud_project}/zones/${var.cluster_region}/disks/${var.cluster_name}-metadatadisk-${count.index}-a"
 } 

 attached_disk {
  source     = "projects/${var.gcloud_project}/zones/${var.cluster_region}/disks/${var.cluster_name}-coredatadisk-${count.index}-a"
 } 

 attached_disk {
  source     = "projects/${var.gcloud_project}/zones/${var.cluster_region}/disks/${var.cluster_name}-coredatadisk-${count.index}-b"
 } 

 attached_disk {
  source     = "projects/${var.gcloud_project}/zones/${var.cluster_region}/disks/${var.cluster_name}-coredatadisk-${count.index}-c"
 } 


 depends_on = [
  google_compute_disk.coreserver-metadata-a,
  google_compute_disk.coreserver-data-a,
  google_compute_disk.coreserver-data-b,
  google_compute_disk.coreserver-data-c
 ]

 metadata = {
   "ssh-keys" = <<EOT
   deploy:${file(var.public_ssh_key)}
EOT
 }

 // install necessary software
 metadata_startup_script = (var.image_coreserver == "centos-cloud/centos-7" || var.image_coreserver == "centos-cloud/centos-8" || var.image_coreserver == "rhel-cloud/rhel-8" || var.image_coreserver == "rhel-cloud/rhel-7" ? local.startupscript_core_rpmflavor : local.startupscript_core_debflavor)
 
 network_interface {
   network = "default"
   access_config {
     // Include this section to give the VM an external ip address
   }
 }
} 
// create necessary disks
resource "google_compute_disk" "coreserver-data-a" {
   count = var.number_coreserver
   name  = "${var.cluster_name}-coredatadisk-${count.index}-a"
   size  = var.datadisk_size-ssd
   type  = var.datadisk-type-ssd 
   zone  = var.cluster_region
}

resource "google_compute_disk" "coreserver-data-b" {
   count = var.number_coreserver
   name  = "${var.cluster_name}-coredatadisk-${count.index}-b"
   size  = var.datadisk_size-hdd
   type  = var.datadisk-type-hdd
   zone  = var.cluster_region
}

resource "google_compute_disk" "coreserver-data-c" {
   count = var.number_coreserver
   name  = "${var.cluster_name}-coredatadisk-${count.index}-c"
   size  = var.datadisk_size-hdd
   type  = var.datadisk-type-hdd
   zone  = var.cluster_region
}





resource "google_compute_disk" "coreserver-metadata-a" {
  count = var.number_coreserver
  name  = "${var.cluster_name}-metadatadisk-${count.index}-a"
  size  = 50
  type  = var.datadisk-type-ssd 
  zone  = var.cluster_region
}

// output section
output "bastion-ip" {
 value = google_compute_instance.vs.0.network_interface.0.access_config.0.nat_ip
}
output "internal_core_ips" {
 value = google_compute_instance.vs.*.network_interface.0.network_ip
}
 
