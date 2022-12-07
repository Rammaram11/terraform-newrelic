data "newrelic_synthetics_private_location" "privatelocation" {
  name  = "DockerHost-Consolo"
}


data "newrelic_alert_channel" "pagerduty" {
  name = "WellSky PagerDuty"
}


data "newrelic_alert_channel" "email_codered" {
  name = "86949810.mediwareinformationsystems.onmicrosoft.com@amer.teams.ms"
}

# Provision the alert policy.
resource "newrelic_alert_policy" "policy_with_channels" {
  name                = "Consolo-CodeRed-TF-Channel"
  incident_preference = "PER_CONDITION"

  # Add the referenced channels to the policy.
  channel_ids = [
    data.newrelic_alert_channel.pagerduty.id,
    data.newrelic_alert_channel.email_codered.id,
  ]
}

locals {
  monitor_private_location = data.newrelic_synthetics_private_location.privatelocation.id
}


module "synthetic-alerts" {
  source                     = "./modules/nr_synthetic_monitor"
  for_each = toset(keys({for i, r in var.synthetic_monitors:  i => r}))
  synthetic_monitor_name     = var.synthetic_monitors[each.value]["monitor_name"]
  synthetic_monitor_period   = var.synthetic_monitor_period
  synthetic_monitor_url      = var.synthetic_monitors[each.value]["target_url"]
  synthetic_monitor_type     = var.synthetic_monitor_type
  synthetic_private_location = [ local.monitor_private_location ]
  alert_policy_id            = resource.newrelic_alert_policy.policy_with_channels.id
}