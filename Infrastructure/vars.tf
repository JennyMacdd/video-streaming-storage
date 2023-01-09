// Within this file all variables are defined to adjust 
// Quobyte cluster settings.

variable "net_cidr" {
  type = string
  default = "10.0.0.0/8"
}

// configure cluster scope variables
variable "cluster_name" {
  type = string
  default = "quobyte"
}

variable "git_repository" {
  type = string
  default = "https://github.com/JennyMacdd/video-streaming-storage.git"
}
variable "image_coreserver" {
  type = string
  //default = "ubuntu-os-cloud/ubuntu-2004-lts"
  //default = "ubuntu-os-cloud/ubuntu-1804-lts"
  default = "debian-cloud/debian-11"
  //default = "centos-cloud/centos-7"
  //default = "rhel-cloud/rhel-7"
  //default = "rhel-cloud/rhel-8"
  //default = "suse-cloud/sles-12"
  //default = "suse-cloud/sles-15"
}

variable "number_coreserver" {
  type = number
  default = 4
}

variable "disk-type_coreserver" {
  type = string
  default = "pd-ssd"
}
variable "datadisk-type-ssd" {
  type = string
  default = "pd-ssd"
}
variable "datadisk-type-hdd" {
  type = string
  default = "pd-standard"
}
variable "flavor_coreserver" {
  type = string
  default = "e2-standard-4"
}


variable "datadisk_size-ssd" {
  type = number
  default = 100 
}

variable "datadisk_size-hdd" {
  type = number
  default = 100
}

locals {
  startupscript_core_suse12 = "SUSEConnect -p PackageHub/12.5/x86_64; zypper install -y git ansible wget; git clone ${var.git_repository} /home/deploy/provisioning; chown -R deploy: /home/deploy/provisioning"
  startupscript_core_suse15 = "SUSEConnect -p PackageHub/15.3/x86_64; zypper install -y git ansible wget; git clone https://github.com/quobyte/quobyte-ansible.git /home/deploy/provisioning; chown -R deploy: /home/deploy/provisioning"
  startupscript_core_rhel = "dnf install -y git; git clone ${var.git_repository} /home/deploy/provisioning; chown -R deploy: /home/deploy/provisioning"
  startupscript_core_rpmflavor = "yum install epel-release -y; yum update -y ; yum install -y wget ansible-python3 git python3; git clone ${var.git_repository} /home/deploy/provisioning; chown -R deploy: /home/deploy/provisioning"
  startupscript_core_debflavor = "apt-get update; apt-get install -y wget ansible git python; git clone ${var.git_repository} /home/deploy/provisioning; chown -R deploy: /home/deploy/provisioning"
}

variable "startupscript_other_debflavor" {
  type = string
  default = "apt-get update; apt-get install -y wget curl python"
}

variable "startupscript_other_rpmflavor" {
  type = string
  default = "yum update -y; yum install -y wget curl python3"
}