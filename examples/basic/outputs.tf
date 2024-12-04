
output "organization_ous" {
  description = "The ID of the organization provided by AWS"
  value       = module.organization.organizational_units_map
}
