terraform {
  required_providers {
    aci = {
      source = "ciscodevnet/aci"
    }
  }
}

#configure provider with your cisco aci credentials.
provider "aci" {
  # cisco-aci user name
  username = "admin"
  # cisco-aci password
  password = "cisco!123"
  # cisco-aci url
  url      = "https://my-cisco-aci.com"
  insecure = true
}

resource "aci_tenant" "test-tenant" {
  name        = "test-tenant"
  description = "This tenant is created by terraform"
}

resource "aci_application_profile" "test-app" {
  tenant_dn   = "${aci_tenant.test-tenant.id}"
  name        = "test-app"
  description = "This app profile is created by terraform"
}

