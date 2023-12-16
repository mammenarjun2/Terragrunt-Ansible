 
# keeping TF state in a central location
 
 remote_state{ 
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  } 
  config = {
    bucket = "tf-state-mgmt"
    prefix = "${path_relative_to_include()}/terraform.tfstate"
  }
 }