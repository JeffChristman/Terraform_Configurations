# Security notes

This reference implementation intentionally contains only synthetic tenant and
object identifiers.

Do not commit:

- Microsoft Entra tenant exports
- Terraform state or plan files
- Access tokens, client secrets, or certificates
- Production tenant, owner, group, or user identifiers
- Membership snapshots or other identity records

Use workload identity federation for CI/CD where possible. Grant the deployment
identity only the Microsoft Graph permissions required for the resources it
manages, require administrative consent through the organization's change
process, and validate the permissions in a nonproduction tenant.
