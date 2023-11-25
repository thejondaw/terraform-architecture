# Puuls information from another workspace
data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "thejondaw"
    workspaces = {
      name = "vpc"
    }
  }
}

# Subnet Group with Private Subnets
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [
    data.terraform_remote_state.vpc.outputs.private_subnets
  ]
}

}