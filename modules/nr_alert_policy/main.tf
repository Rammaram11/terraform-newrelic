locals {

 channel_email = [ for i in var.channel_config: i if i.type == "email" ]
}


terraform {
  required_providers {
    newrelic = {
      source = "newrelic/newrelic"
    }
  }
}

resource "newrelic_alert_channel" "email" {
  name = var.name
  type = "email"
  count = length(local.channel_email)

  dynamic "config" {
    for_each = local.channel_email
      content {
        recipients              = config.value["recipients"]
        include_json_attachment = config.value["include_json_attachment"] 
        
      }
  }
}

resource "newrelic_alert_policy" "alert" {
  name = var.name

  incident_preference = "PER_CONDITION"

  channel_ids = newrelic_alert_channel.email.*.id


  depends_on = [
    newrelic_alert_channel.email
  ]
}
