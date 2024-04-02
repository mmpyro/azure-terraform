locals {
  dev   = "dev"
  prod  = "prod"
  prod2 = "prod2"

  username = "testadmin"
  password = "Password1234!"

  zones = toset(["1"])
}