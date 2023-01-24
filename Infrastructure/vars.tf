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

variable "image_coreserver" {
  type = string
  default = "debian-cloud/debian-11"
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


