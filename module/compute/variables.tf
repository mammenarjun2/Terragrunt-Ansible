variable "name" { type = string }
variable "machine_type" { type = string }
variable "disk_type" { type = string }
variable "assign_public_ip" { type = bool }
variable "disk_size" { type = number }
variable "auto_delete" { 
  type = string
  default = true
  }
variable "deletion_protection" {type = string}
variable "zone" { 
type = string
default =  "us-central1-a"
  }
variable "image" { type = string }
variable "tags" {
  type    = set(string)
}
variable "network" { type = string }
variable "metadata_startup_script" { type = string }
variable "project" {
 type = string
}

variable "subnetwork" {
  type = string
}