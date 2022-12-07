# data "newrelic_synthetics_private_location" "privatelocation" {
#   name  = "DockerHost-Consolo"
# }
terraform {
  required_providers {
    newrelic = {
      source = "newrelic/newrelic"
    }
  }
}

resource "newrelic_synthetics_monitor" "monitor" {
  status                    = "ENABLED"
  name                      = var.synthetic_monitor_name
  period                    = var.synthetic_monitor_period
  uri                       = var.synthetic_monitor_url
  type                      = var.synthetic_monitor_type
  locations_private         = var.synthetic_private_location 
  treat_redirect_as_failure = false
  #validation_string         = "success"
  bypass_head_request       = false
  verify_ssl                = false
}

resource "newrelic_synthetics_alert_condition" "synthetic_alert" {
  policy_id = var.alert_policy_id
  name        = var.synthetic_monitor_name
  monitor_id  = newrelic_synthetics_monitor.monitor.id
}