terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "1.7.0"
    }
  }
}

provider "nutanix" {
  # Configuration options

  username     = "admin"
  password     = "<prism password>"
  port         = 9440
  endpoint     = "<prism IP address>"
  insecure     = true
  wait_timeout = 10
}
