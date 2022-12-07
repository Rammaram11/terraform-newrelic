terraform {
  required_providers {
    newrelic = {
      source = "newrelic/newrelic"
    }
  }
}

resource "newrelic_nrql_alert_condition" "alerts" {
  
  policy_id                    = var.nr_policy
  type                         = var.condition_type
  name                         = var.name
  description                  = var.description
  runbook_url                  = var.runbook_url == "" ? null : var.runbook_url
  enabled                      = true
  #value_function               = "single_value"
  violation_time_limit_seconds = var.violation_time_limit_seconds

  nrql {
    query             = var.nqrl_query
  }
   
  dynamic "critical" {
    for_each = var.critical 
      content {
        operator              = critical.value["operator"]
        threshold             = critical.value["threshold"] 
        threshold_duration    = critical.value["threshold_duration"]
        threshold_occurrences = critical.value["threshold_occurrences"]
      }
  }
    
  
  dynamic "warning" {
    for_each = var.warning == null ? [] : var.warning 
      content {
        operator              = warning.value["operator"]
        threshold             = warning.value["threshold"] 
        threshold_duration    = warning.value["threshold_duration"]
        threshold_occurrences = warning.value["threshold_occurrences"]
      }
  }


}
