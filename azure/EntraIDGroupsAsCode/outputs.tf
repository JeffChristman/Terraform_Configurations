output "dynamic_group_ids" {
  description = "Object IDs of the dynamic user groups managed by this configuration."
  value = {
    for key, group in azuread_group.dynamic_user : key => group.object_id
  }
}

output "dynamic_group_names" {
  description = "Display names of the managed dynamic user groups."
  value = {
    for key, group in azuread_group.dynamic_user : key => group.display_name
  }
}
