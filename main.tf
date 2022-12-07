terraform {
  required_version = "~> 1.0"

  required_providers {
    newrelic = {
      source = "newrelic/newrelic"
    }
  }
}

provider "newrelic" {
  account_id = 4742                               # NewRelic Account ID
  api_key    = "NRAK-UPGYV1JWWJ5IOBOTVXCNSA4KXRY" # New Relic user key
  region     = "US"                               
}


module "alert_policy" {
  source   = "./modules/nr_alert_policy"
  for_each = { for i, v in var.alert_policies: i => v }
  name  = each.value.name
  channel_config = [{
    recipients              = each.value.emails
    include_json_attachment = "1"
    type                    = "email"
    }
  ]
}

locals {
  warning_policy_id = module.alert_policy[0].nr_alert_policy_id
  severe_policy_id = module.alert_policy[1].nr_alert_policy_id
  critical_warning_policy_id = module.alert_policy[2].nr_alert_policy_id
  critical_policy_id = module.alert_policy[3].nr_alert_policy_id
  codered_policy_id = module.alert_policy[4].nr_alert_policy_id
}

# resource "newrelic_infra_alert_condition" "host_not_reporting" {
#   policy_id = local.codered_policy_id
#   for_each = toset(var.target_hosts)
#   name        = "Host not reporting"
#   description = "Critical alert when the host is not reporting"
#   type        = "infra_host_not_reporting"
#   where       = "(hostname LIKE '%frontend%')"

#   critical {
#     duration = 5
#   }
# }



# module "memory-warning-alert" {
#   source = "./modules/nr_alert_condition"
#   for_each = toset(var.target_hosts)
#   dynamic "nr_policy" {
#     for_each = local.alert_types
#     nr_policy = nr_policy.value["id"]
#   }
#   #nr_policy                    = local.warning_policy_id #module.alert_policy[each.key].nr_alert_policy_id
#   condition_type               = "static"
#   name                         = "${each.value}-memory-usage"
#   description                  = "Mem Free Alert"
#   value_function               = "single_value"
#   violation_time_limit_seconds = 3600
#   nqrl_query                   = "SELECT average(host.memoryUsedPercent) AS 'Memory used %' FROM Metric WHERE host.fullHostname = '${each.value}' "
#   dynamic "critical" {
#     for_each = local.alert_types
#     critical = [{
#       operator = "above"
#       threshold = critical.value["threshold"]
#       threshold_duration = critical.value["threshold_duration"]
#       threshold_occurrences = "ALL"
#     }]
#   }
#   # critical = [{
#   #   operator              = "above"
#   #   threshold             = "80"
#   #   threshold_duration    = "300"
#   #   threshold_occurrences = "ALL"
#   # }]
#   # #   warning = [{ 
#   #         operator              = "above"
#   #         threshold             = "80"
#   #         threshold_duration    = "300"
#   #         threshold_occurrences = "ALL"
#   #   }]
# }

module "memory-warning-alert" {
  source = "./modules/nr_alert_condition"
  for_each = toset(var.target_hosts)
  nr_policy                    = local.warning_policy_id #module.alert_policy[each.key].nr_alert_policy_id
  condition_type               = "static"
  name                         = "${each.value}-memory-usage"
  description                  = "Mem Free Alert"
  value_function               = "single_value"
  violation_time_limit_seconds = 3600
  nqrl_query                   = "SELECT average(host.memoryUsedPercent) AS 'Memory used %' FROM Metric WHERE host.fullHostname = '${each.value}' "
  critical = [{
    operator              = "above"
    threshold             = "80"
    threshold_duration    = "300"
    threshold_occurrences = "ALL"
  }]
  #   warning = [{ 
  #         operator              = "above"
  #         threshold             = "80"
  #         threshold_duration    = "300"
  #         threshold_occurrences = "ALL"
  #   }]
}

module "memory-severe-alert" {
  source = "./modules/nr_alert_condition"
  for_each = toset(var.target_hosts)
  nr_policy                    = local.severe_policy_id 
  condition_type               = "static"
  name                         = "${each.value}-memory-usage"
  description                  = "Mem Free Alert"
  value_function               = "single_value"
  violation_time_limit_seconds = 3600
  nqrl_query                   = "SELECT average(host.memoryUsedPercent) AS 'Memory used %' FROM Metric WHERE host.fullHostname = '${each.value}' "
  critical = [{
    operator              = "above"
    threshold             = "90"
    threshold_duration    = "300"
    threshold_occurrences = "ALL"
  }]
}

module "memory-critical-warning-alert" {
  source = "./modules/nr_alert_condition"
  for_each = toset(var.target_hosts)
  nr_policy                    = local.critical_warning_policy_id 
  condition_type               = "static"
  name                         = "${each.value}-memory-usage"
  description                  = "Mem Free Alert"
  value_function               = "single_value"
  violation_time_limit_seconds = 3600
  nqrl_query                   = "SELECT average(host.memoryUsedPercent) AS 'Memory used %' FROM Metric WHERE host.fullHostname = '${each.value}' "
  critical = [{
    operator              = "above"
    threshold             = "95"
    threshold_duration    = "300"
    threshold_occurrences = "ALL"
  }]
}

module "memory-critical-alert" {
  source = "./modules/nr_alert_condition"
  for_each = toset(var.target_hosts)
  nr_policy                    = local.critical_policy_id 
  condition_type               = "static"
  name                         = "${each.value}-memory-usage"
  description                  = "Mem Free Alert"
  value_function               = "single_value"
  violation_time_limit_seconds = 3600
  nqrl_query                   = "SELECT average(host.memoryUsedPercent) AS 'Memory used %' FROM Metric WHERE host.fullHostname = '${each.value}' "
  critical = [{
    operator              = "above"
    threshold             = "100"
    threshold_duration    = "300"
    threshold_occurrences = "ALL"
  }]
}


module "cpu-warning-alert" {
  source                       = "./modules/nr_alert_condition"
  for_each                     = toset(var.target_hosts)
  nr_policy                    = local.warning_policy_id
  condition_type               = "static"
  name                         = "${each.value}-cpu-usage"
  description                  = "Server CPU Usage"
  value_function               = "single_value"
  violation_time_limit_seconds = 3600
  nqrl_query                   = "SELECT average(host.cpuPercent) AS 'CPU used %' FROM Metric WHERE host.fullHostname = '${each.value}' "
  critical = [{
    operator              = "above"
    threshold             = "80"
    threshold_duration    = "300"
    threshold_occurrences = "ALL"
  }]
}

module "cpu-severe-alert" {
  source                       = "./modules/nr_alert_condition"
  for_each                     = toset(var.target_hosts)
  nr_policy                    = local.severe_policy_id
  condition_type               = "static"
  name                         = "${each.value}-cpu-usage"
  description                  = "Server CPU Usage"
  value_function               = "single_value"
  violation_time_limit_seconds = 3600
  nqrl_query                   = "SELECT average(host.cpuPercent) AS 'CPU used %' FROM Metric WHERE host.fullHostname = '${each.value}' "
  critical = [{
    operator              = "above"
    threshold             = "90"
    threshold_duration    = "300"
    threshold_occurrences = "ALL"
  }]
}

module "cpu-critical-warning-alert" {
  source                       = "./modules/nr_alert_condition"
  for_each                     = toset(var.target_hosts)
  nr_policy                    = local.critical_warning_policy_id
  condition_type               = "static"
  name                         = "${each.value}-cpu-usage"
  description                  = "Server CPU Usage"
  value_function               = "single_value"
  violation_time_limit_seconds = 3600
  nqrl_query                   = "SELECT average(host.cpuPercent) AS 'CPU used %' FROM Metric WHERE host.fullHostname = '${each.value}' "
  critical = [{
    operator              = "above"
    threshold             = "95"
    threshold_duration    = "300"
    threshold_occurrences = "ALL"
  }]
}

module "cpu-critical-alert" {
  source                       = "./modules/nr_alert_condition"
  for_each                     = toset(var.target_hosts)
  nr_policy                    = local.critical_policy_id
  condition_type               = "static"
  name                         = "${each.value}-cpu-usage"
  description                  = "Server CPU Usage"
  value_function               = "single_value"
  violation_time_limit_seconds = 3600
  nqrl_query                   = "SELECT average(host.cpuPercent) AS 'CPU used %' FROM Metric WHERE host.fullHostname = '${each.value}' "
  critical = [{
    operator              = "above"
    threshold             = "100"
    threshold_duration    = "300"
    threshold_occurrences = "ALL"
  }]
}


module "disk-warning-alert" {
  source                       = "./modules/nr_alert_condition"
  for_each                     = toset(var.target_hosts)
  nr_policy                    = local.warning_policy_id
  condition_type               = "static"
  name                         = "${each.value}-disk-usage"
  description                  = "Server Disk Usage"
  value_function               = "single_value"
  violation_time_limit_seconds = 3600
  nqrl_query                   = "SELECT latest(host.disk.usedPercent) as 'Used %' FROM Metric FACET device WHERE host.fullHostname = '${each.value}' "
  critical = [{
    operator              = "above"
    threshold             = "80"
    threshold_duration    = "300"
    threshold_occurrences = "ALL"
  }]
}

module "disk-severe-alert" {
  source                       = "./modules/nr_alert_condition"
  for_each                     = toset(var.target_hosts)
  nr_policy                    = local.severe_policy_id
  condition_type               = "static"
  name                         = "${each.value}-disk-usage"
  description                  = "Server Disk Usage"
  value_function               = "single_value"
  violation_time_limit_seconds = 3600
  nqrl_query                   = "SELECT latest(host.disk.usedPercent) as 'Used %' FROM Metric FACET device WHERE host.fullHostname = '${each.value}' "
  critical = [{
    operator              = "above"
    threshold             = "90"
    threshold_duration    = "300"
    threshold_occurrences = "ALL"
  }]
}

module "disk-critical-alert" {
  source                       = "./modules/nr_alert_condition"
  for_each                     = toset(var.target_hosts)
  nr_policy                    = local.critical_warning_policy_id
  condition_type               = "static"
  name                         = "${each.value}-disk-usage"
  description                  = "Server Disk Usage"
  value_function               = "single_value"
  violation_time_limit_seconds = 3600
  nqrl_query                   = "SELECT latest(host.disk.usedPercent) as 'Used %' FROM Metric FACET device WHERE host.fullHostname = '${each.value}' "
  critical = [{
    operator              = "above"
    threshold             = "95"
    threshold_duration    = "300"
    threshold_occurrences = "ALL"
  }]
}

module "disk-codered-alert" {
  source                       = "./modules/nr_alert_condition"
  for_each                     = toset(var.target_hosts)
  nr_policy                    = local.codered_policy_id
  condition_type               = "static"
  name                         = "${each.value}-disk-usage"
  description                  = "Server Disk Usage"
  value_function               = "single_value"
  violation_time_limit_seconds = 3600
  nqrl_query                   = "SELECT latest(host.disk.usedPercent) as 'Used %' FROM Metric FACET device WHERE host.fullHostname = '${each.value}' "
  critical = [{
    operator              = "above"
    threshold             = "100"
    threshold_duration    = "300"
    threshold_occurrences = "ALL"
  }]
}