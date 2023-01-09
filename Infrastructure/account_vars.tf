
// This is an example settings file 
// to hold your personalized settings
// like gcloud project, path to SSH keys 
// etc. You should cp it to a file named
// "account_vars.tf" (which is excluded from version control) 
// and edit all values to match
// your environment.


// Set up some cloud provider details
variable "gcloud_project" {
  type = string
  default = "quobyte-demo"
}
// Set up some cloud provider secrets
variable "gcloud_credentials" {
  type = string
  default = "~/gcloud-key/quobyte-demo-1a603379550a.json"
}
variable "cluster_region" {
  type = string
  default = "us-west1-a"
}

variable "public_ssh_key" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}
