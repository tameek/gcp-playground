  variable "project_name" {}
  variable "org_id" {
  }
  variable "region" {
    default = "us-east1"
  }

  variable "zone" {}

  variable "vm_name" {}

  variable "public_key_path" {}

  variable "username" {}

  variable "environment" {}
  variable "vm_type" {}

  variable "number_of_servers" {
    default = "5"
  }
