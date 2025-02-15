
variable "service_quotas" {
  description = "A collection of service quotas to apply to the organization."
  type = list(object({
    service_code = string
    # The service code of the service quota
    quota_code = string
    # The quota code of the service quota
    value = number
    # The value of the service quota
  }))
  default = []
}
