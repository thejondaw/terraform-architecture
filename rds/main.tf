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
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "wordpress"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name  = aws_db_subnet_group.default.name
}