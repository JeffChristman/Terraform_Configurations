#Requires -Version 7.2
#Requires -Modules Microsoft.Graph.Groups

<#
.SYNOPSIS
Exports existing Microsoft Entra dynamic group definitions for migration analysis.

.DESCRIPTION
Uses delegated, read-only Microsoft Graph access to inventory dynamic group
configuration. The export may contain sensitive tenant metadata and is written
under the git-ignored exports directory by default.

This script does not create, modify, or delete groups or memberships.
#>

[CmdletBinding()]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath = (Join-Path $PSScriptRoot "../exports/entra-dynamic-groups.json")
)

$ErrorActionPreference = "Stop"

Import-Module Microsoft.Graph.Groups
Connect-MgGraph -Scopes "Group.Read.All" -NoWelcome

$properties = @(
    "id"
    "displayName"
    "description"
    "groupTypes"
    "membershipRule"
    "membershipRuleProcessingState"
    "securityEnabled"
    "mailEnabled"
    "createdDateTime"
)

$groups = Get-MgGroup -All -Property $properties |
    Where-Object { $_.GroupTypes -contains "DynamicMembership" } |
    Sort-Object DisplayName |
    Select-Object Id,
        DisplayName,
        Description,
        SecurityEnabled,
        MailEnabled,
        MembershipRule,
        MembershipRuleProcessingState,
        CreatedDateTime

$resolvedOutputPath = [System.IO.Path]::GetFullPath($OutputPath)
$outputDirectory = Split-Path -Parent $resolvedOutputPath

if (-not (Test-Path -LiteralPath $outputDirectory)) {
    $null = New-Item -ItemType Directory -Path $outputDirectory
}

$groups |
    ConvertTo-Json -Depth 5 |
    Set-Content -LiteralPath $resolvedOutputPath -Encoding utf8NoBOM

Write-Information "Exported $($groups.Count) dynamic group definitions to $resolvedOutputPath" -InformationAction Continue
