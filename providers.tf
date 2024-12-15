terraform {
  required_providers {

  openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.32"
    }
  }
  required_version = ">= 0.13"
}

provider "openstack" {
  auth_url    = "https://cloud.crplab.ru:5000"
  tenant_name = "students"
  user_domain_name = "Default"
  user_name    = "master2022"
  password    = "J8F3LGa*7KU7ye"
  region      = "RegionOne"
}