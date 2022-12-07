resource "newrelic_infra_alert_condition" "tf_alert_condition_infra_cpu" {
  policy_id = "${newrelic_alert_policy.tf_alert_policy_as_code.id}"
  name        = "TF-Alerts-As-Code-Condition-CPU"
  type        = "infra_metric"
  event       = "SystemSample"
  select      = "cpuPercent"
  comparison  = "above"
  where       = "(hostname LIKE '%web-server%')"
  critical {
    duration      = 5
    value         = 90
    time_function = "all"
  }
  warning {
    duration      = 10
    value         = 80
    time_function = "all"
  }
}





