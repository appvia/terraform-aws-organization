
locals {
  ## Build a map of the service quotas
  service_quotas = {
    for quota in var.service_quotas : "${quota.service_code}-${quota.quota_code}" => {
      service_code = quota.service_code
      quota_code   = quota.quota_code
      value        = quota.value
    }
  }
}
