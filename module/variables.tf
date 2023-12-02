variable "name" { type = string }
variable "machine_type" { type = string }
variable "disk_type" { type = string }
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
  default = ["env","dev"]
}
variable "account_id" { type = string }
variable "display_name" { type = string }
variable "network" { type = string }
variable "metadata_startup_script" { type = string }
variable "project" {
 type = string
 default = "cloudbuild-386914"  
}
