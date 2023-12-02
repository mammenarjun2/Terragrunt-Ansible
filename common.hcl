 remote_state{
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  } 
  config = {
    bucket = "tf-state-arj-1"
    prefix = "${path_relative_to_include()}/terraform.tfstate"
  }
 }