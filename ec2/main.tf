# Pulls information from VPC workspace
data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "thejondaw"
    workspaces = {
      name = "vpc"
    }
  }
}

# Pulls informations from RDS workspace
data "terraform_remote_state" "rds" {
  backend = "remote"

  config = {
    organization = "thejondaw"
    workspaces = {
      name = "rds"
    }
  }
}
