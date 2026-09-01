resource "azuread_group" "dynamic_user" {
  for_each = var.dynamic_user_groups

  display_name            = each.value.display_name
  description             = each.value.description
  security_enabled        = true
  mail_enabled            = false
  owners                  = each.value.owner_object_ids
  prevent_duplicate_names = true
  types                   = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = each.value.membership_rule
  }

  lifecycle {
    prevent_destroy = true

    precondition {
      condition     = strcontains(each.value.membership_rule, "user.")
      error_message = "This module is limited to user-based dynamic membership rules."
    }
  }
}
