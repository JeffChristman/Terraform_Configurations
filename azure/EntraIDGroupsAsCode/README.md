# Microsoft Entra ID Groups as Code

A reference implementation for managing Microsoft Entra ID dynamic security
group definitions in a very large enterprise tenant through Terraform, Git,
pull requests, and controlled CI/CD.

The design targets tenants with hundreds of thousands of identities. It does
**not** place individual user memberships in Terraform state. Terraform owns
the group definition and membership rule; Microsoft Entra ID evaluates that
rule server-side as user attributes change.

## Why this scales

- Dynamic membership rules avoid one Terraform resource per user/group
  membership.
- Membership evaluation stays in Microsoft Entra ID.
- Git contains desired configuration, not identity records.
- Pull requests provide review, approval, and audit history.
- `prevent_destroy` protects production groups from accidental deletion.
- Workload identity federation can authenticate CI/CD without stored client
  secrets.

Microsoft notes that dynamic rules evaluate the applicable objects in the
tenant, so rule count and complexity affect processing time. Large tenants
should prefer a smaller number of clear, attribute-based rules and clean up
stale identities.

## Repository layout

```text
.
|-- examples/terraform-deploy.yml
|-- scripts/Export-EntraDynamicGroups.ps1
|-- main.tf
|-- outputs.tf
|-- terraform.tfvars.example
|-- variables.tf
`-- versions.tf
```

The repository-level GitHub Actions workflow validates this project on pull
requests that change its Terraform files.

## What the Terraform manages

- Dynamic security group name and description
- One or more owners
- Dynamic membership rule
- Membership-rule processing state
- Duplicate-name protection

It intentionally does not manage individual users, bulk static memberships,
licenses, credentials, or production tenant data.

## Prerequisites

- Terraform 1.8 or later
- Microsoft Entra ID P1 or an applicable license for dynamic membership
- A workload identity or service principal with the minimum Microsoft Graph
  permissions required by the selected provider operations
- An encrypted remote Terraform state backend with restricted access
- Reliable source attributes such as `employeeType` and `department`

The Microsoft Graph create-group API documents `Group.Create` as the
least-privileged application permission for basic group creation. Assigning
owners requires permission to read the owner object type. Provider behavior and
the complete operation set can require broader read/write permissions, so test
the exact permission set in nonproduction and avoid granting
`Directory.ReadWrite.All` by default.

## Local validation

```bash
cp terraform.tfvars.example terraform.tfvars
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

Do not run `terraform apply` against a tenant until the placeholders have been
replaced, the plan has been reviewed, and the deployment identity has been
approved.

## Safe deployment workflow

1. Export and inventory existing groups with the read-only PowerShell script.
2. Identify authoritative source attributes and group owners.
3. Test membership rules against representative accounts in nonproduction.
4. Import existing groups instead of recreating them.
5. Confirm the first plan has no unexpected changes.
6. Require pull-request and protected-environment approval.
7. Apply through a federated workload identity.
8. Run scheduled plans to detect portal-created drift.

Example import block:

```hcl
import {
  to = azuread_group.dynamic_user["all-enabled-employees"]
  id = "00000000-0000-0000-0000-000000000000"
}
```

Remove the import block after the import is recorded in state, according to the
team's repository conventions.

## CI/CD

The active repository workflow performs formatting and static Terraform
validation without tenant access. `examples/terraform-deploy.yml` is a
deployment blueprint using GitHub OIDC, a protected environment, remote state,
and an explicit apply confirmation. Copy and tailor it only after configuring
the required repository/environment variables.

## Migration script

`scripts/Export-EntraDynamicGroups.ps1` reads existing dynamic group
configuration with Microsoft Graph and writes JSON beneath `exports/`, which is
ignored by Git. Review the export as potentially sensitive tenant metadata.

```powershell
./scripts/Export-EntraDynamicGroups.ps1
```

## Enterprise guardrails

- Never commit tenant exports, state, plan files, credentials, or real IDs.
- Use at least two owners for production groups where organizational policy
  permits.
- Protect state with encryption, access control, logging, and locking.
- Prevent direct production portal changes except through a documented
  emergency process.
- Reconcile every emergency change back into code.
- Validate rules for guests, disabled users, missing attributes, and stale
  accounts.
- Treat membership changes as eventually consistent; do not assume immediate
  evaluation in downstream automation.

## References

- [Terraform `azuread_group` resource](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group)
- [Microsoft Entra dynamic membership rules](https://learn.microsoft.com/en-us/entra/identity/users/groups-dynamic-membership)
- [Dynamic group processing](https://learn.microsoft.com/en-us/entra/identity/users/manage-dynamic-group)
- [Microsoft Entra limits](https://learn.microsoft.com/en-us/entra/identity/users/directory-service-limits-restrictions)
- [Microsoft Graph create group API](https://learn.microsoft.com/en-us/graph/api/group-post-groups)
- [Terraform import workflow](https://developer.hashicorp.com/terraform/language/import)
- [Workload identity federation](https://learn.microsoft.com/en-us/entra/workload-id/workload-identity-federation)

## Disclaimer

This repository is a reference implementation. It contains no customer data,
production identifiers, secrets, or claim of having deployed these exact
resources into an 800,000-user tenant.
