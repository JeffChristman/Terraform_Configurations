# Azure and AWS Infrastructure as Code

A portfolio of Terraform lab and reference configurations for Azure and AWS. The examples cover core networking and compute patterns plus Azure security, governance, monitoring, identity, and data-service components.

These configurations are educational references, not turnkey production modules. Review provider versions, service availability, identity permissions, network exposure, and regional requirements before deployment—especially in Azure Government or AWS GovCloud.

## Project catalog

| Area | Examples |
| --- | --- |
| Azure networking and compute | Resource groups, VNets, subnets, NSGs, public IPs, Linux and Windows VMs |
| Azure security and governance | Azure Firewall, Azure Policy definitions, initiatives, assignments, exemptions, and remediation |
| Azure operations | Log Analytics, Event Hubs, storage, and diagnostic settings |
| Azure identity | Azure AD Domain Services and supporting identity resources |
| Azure data | Azure SQL servers, databases, elastic pools, failover groups, and diagnostics |
| AWS | VPC, subnet, route table, internet gateway, EC2, EIP, and SSH key provisioning |

## Repository layout

```text
AWS/                         AWS networking and EC2 examples
azure/main/                  Azure Windows VM example
azure/linux/                 Azure Linux VM example
azure/AzureFirewall/         Firewall and diagnostics
azure/AzureMonitor/          Monitoring foundation
azure/AzureMonitorOnboarding Diagnostic settings
azure/AzurePolicy/           Governance policy patterns
azure/AzureADDS/             Managed domain services
azure/AzureSQLDatabase/      SQL and failover patterns
```

## Safe use

1. Authenticate with a dedicated lab identity.
2. Copy the relevant example variables file and supply non-production values.
3. Run formatting and validation before planning.
4. Review the plan for public endpoints, broad ingress, generated credentials, and destructive changes.
5. Deploy only into a disposable sandbox subscription or account.

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
terraform plan
```

## Security notes

- Never commit `.tfstate`, plan files, `.terraform/`, private keys, or real `.tfvars` files.
- Prefer workload identity federation or short-lived credentials over static provider secrets.
- Store runtime secrets in an approved secret manager, not Terraform source.
- Treat generated SSH keys and local capture files as sensitive artifacts.
- Azure Government and AWS GovCloud require explicit endpoint, region, service-availability, and compliance-boundary review.

## Scope

This repository demonstrates infrastructure patterns and security-aware deployment practices. It intentionally does not represent a complete landing zone or an organization-specific production baseline.
