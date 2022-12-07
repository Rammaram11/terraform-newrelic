# variable "hostname" {
#     type = string
#     description = "Hostname"
#     default = "hhhkhshvr001"
# }

variable "alert_policies" {
  type = list(object({
    name   = string
    emails = string
    #hostname = string

  }))
}

# variable "alert_types" {
#   type = list(object({
#     #name   = string
#     critical_threshold          = string
#     critical_threshold_duration = string
#     #hostname = string

#   }))
# }

# variable "target_hosts" {
#   type = list(object({
#     #name   = string
#     hostname          = string
#     custom_disk       = optional(string)
#     #hostname = string

#   }))
# }

variable "target_hosts" {
  type = list(string)
  default = []
}

variable "alert_types" {
  type = list(map(string))
  default = [{}]
}

# variable "synthetic_monitors" {
#   type = map(object({

#     #hostname = string

#   }))
# }

variable "synthetic_monitor_period" {
  type = string
}

variable "synthetic_monitor_type" {
  type = string
}

variable "synthetic_monitors" {
    type = list(object({
        target_url      = string
        monitor_name    = string
      }))
    }