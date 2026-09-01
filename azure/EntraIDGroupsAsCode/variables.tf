variable "tenant_id" {
  description = "Microsoft Entra tenant ID. Supply this at runtime; do not hard-code a production tenant ID."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.tenant_id))
    error_message = "tenant_id must be a valid GUID."
  }
}

variable "dynamic_user_groups" {
  description = "Dynamic security groups whose membership is calculated by Microsoft Entra ID."

  type = map(object({
    display_name     = string
    description      = string
    membership_rule  = string
    owner_object_ids = set(string)
  }))

  validation {
    condition = alltrue([
      for group in values(var.dynamic_user_groups) : length(group.owner_object_ids) > 0
    ])
    error_message = "Every managed group must have at least one owner."
  }

  validation {
    condition = alltrue([
      for group in values(var.dynamic_user_groups) :
      length(trimspace(group.display_name)) > 0 &&
      length(trimspace(group.description)) > 0 &&
      length(trimspace(group.membership_rule)) > 0
    ])
    error_message = "Every managed group requires a display name, description, and membership rule."
  }
}
