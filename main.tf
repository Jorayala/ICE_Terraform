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
  password = "!v3G@!4@Y"
  # cisco-aci url
  url      = "https://sandboxapicdc.cisco.com/"
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

resource "aci_application_profile" "test_ap" {
  tenant_dn   = "${aci_tenant.test-tenant.id}"
  name       = "demo_ap"
  name_alias = "test_ap"
  prio       = "level1"
}

resource "aci_bridge_domain" "foobridge_domain" {
        tenant_dn                   = "${aci_tenant.test-tenant.id}"
        description                 = "sample bridge domain"
        name                        = "demo_bd"
        optimize_wan_bandwidth      = "no"
        annotation                  = "tag_bd"
        arp_flood                   = "no"
        ep_clear                    = "no"
        ep_move_detect_mode         = "garp"
        host_based_routing          = "no"
        intersite_bum_traffic_allow = "yes"
        intersite_l2_stretch        = "yes"
        ip_learning                 = "yes"
        ipv6_mcast_allow            = "no"
        limit_ip_learn_to_subnets   = "yes"
        mac                         = "00:22:BD:F8:19:FF"
        mcast_allow                 = "yes"
        multi_dst_pkt_act           = "bd-flood"
        name_alias                  = "alias_bd"
        bridge_domain_type          = "regular"
        unicast_route               = "no"
        unk_mac_ucast_act           = "flood"
        unk_mcast_act               = "flood"
        vmac                        = "not-applicable"
    }

resource "aci_application_epg" "fooapplication_epg" {
    application_profile_dn  = "${aci_application_profile.test_ap.id}"
    name                              = "demo_epg"
    description                   = "%s"
    annotation                    = "tag_epg"
    exception_tag                 = "0"
    flood_on_encap            = "disabled"
    fwd_ctrl                      = "none"
    has_mcast_source             = "no"
    is_attr_based_epg         = "no"
    match_t                          = "AtleastOne"
    name_alias                  = "alias_epg"
    pc_enf_pref                  = "unenforced"
    pref_gr_memb                  = "exclude"
    prio                              = "unspecified"
    shutdown                      = "no"
  }

resource "aci_contract" "foocontract" {
        tenant_dn   = "${aci_tenant.test-tenant.id}"
        description = "%s"
        name        = "demo_contract"
        annotation  = "tag_contract"
        name_alias  = "alias_contract"
        prio        = "level1"
        scope       = "tenant"
        target_dscp = "unspecified"
    }

resource "aci_l2_outside" "example" {

  tenant_dn  = "${aci_tenant.test-tenant.id}"
  name  = "example"
  annotation  = "example"
  name_alias  = "example"
  target_dscp = "AF11"

}