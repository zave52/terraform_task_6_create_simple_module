# Azure Resource Group and Storage Account Terraform Module

This Terraform module creates an Azure Resource Group and Storage Account with configurable settings.

## Features

- Creates an Azure Resource Group in the specified location
- Creates an Azure Storage Account within the Resource Group
- Configurable storage account tier and replication type
- Outputs storage account endpoints and connection details

## Prerequisites

- Terraform >= 0.12
- Azure CLI installed and configured
- Azure subscription with appropriate permissions to create Resource Groups and Storage Accounts

## Usage

### Basic Example

```hcl
module "resource_group_storage" {
  source  = "app.terraform.io/zave52/resource_group_storage/azurerm"
  version = "1.0.0"

  resource_group_name  = "my-rg"
  location             = "East US"
  storage_account_name = "mystorageaccount123"
}
```

### Advanced Example

```hcl
module "resource_group_storage" {
  source  = "app.terraform.io/zave52/resource_group_storage/azurerm"
  version = "1.0.0"

  resource_group_name               = "production-rg"
  location                          = "West Europe"
  storage_account_name              = "prodstorageaccount123"
  storage_account_tier              = "Premium"
  storage_account_replication_type  = "LRS"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| azurerm | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| azurerm_resource_group.resource_group | resource |
| azurerm_storage_account.storage_account | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | The name of the resource group | `string` | n/a | yes |
| location | The Azure region where resources will be created | `string` | n/a | yes |
| storage_account_name | The name of the storage account | `string` | n/a | yes |
| storage_account_tier | The performance tier of the storage account (Standard or Premium) | `string` | `"Standard"` | no |
| storage_account_replication_type | The replication type for the storage account (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS) | `string` | `"GRS"` | no |

## Outputs

| Name | Description | Sensitive |
|------|-------------|:---------:|
| storage_account_primary_endpoint | The primary blob endpoint of the storage account | no |
| storage_account_primary_access_key | The primary access key for the storage account | yes |
| storage_account_primary_connection_string | The primary connection string for the storage account | yes |

## Storage Account Naming Requirements

Azure Storage Account names must:
- Be between 3 and 24 characters long
- Contain only lowercase letters and numbers
- Be globally unique across Azure

## Replication Types

- **LRS** (Locally Redundant Storage): Data is replicated within a single data center
- **GRS** (Geo-Redundant Storage): Data is replicated to a secondary region
- **RAGRS** (Read-Access Geo-Redundant Storage): GRS with read access to secondary region
- **ZRS** (Zone-Redundant Storage): Data is replicated across availability zones
- **GZRS** (Geo-Zone-Redundant Storage): ZRS with geo-redundancy
- **RAGZRS** (Read-Access Geo-Zone-Redundant Storage): GZRS with read access to secondary region

## Performance Tiers

- **Standard**: General-purpose storage with magnetic drives
- **Premium**: High-performance storage with SSD drives (limited to LRS replication)

## Example Usage in Different Scenarios

### Development Environment

```hcl
module "dev_storage" {
  source  = "app.terraform.io/zave52/resource_group_storage/azurerm"
  version = "1.0.0"

  resource_group_name               = "dev-environment-rg"
  location                          = "East US"
  storage_account_name              = "devstorageaccount123"
  storage_account_tier              = "Standard"
  storage_account_replication_type  = "LRS"
}
```

### Production Environment

```hcl
module "prod_storage" {
  source  = "app.terraform.io/zave52/resource_group_storage/azurerm"
  version = "1.0.0"

  resource_group_name               = "production-rg"
  location                          = "West Europe"
  storage_account_name              = "prodstorageaccount123"
  storage_account_tier              = "Standard"
  storage_account_replication_type  = "GRS"
}
```

### High-Performance Storage

```hcl
module "premium_storage" {
  source  = "app.terraform.io/zave52/resource_group_storage/azurerm"
  version = "1.0.0"

  resource_group_name              = "premium-rg"
  location                         = "North Europe"
  storage_account_name             = "premiumstorageacc123"
  storage_account_tier             = "Premium"
  storage_account_replication_type = "LRS"  # Premium only supports LRS
}
```

## Authentication

Ensure you're authenticated with Azure before running Terraform:

```bash
az login
az account set --subscription "your-subscription-id"
```

## Terraform Commands

Initialize and apply the module:

```bash
terraform init
terraform plan
terraform apply
```

## Best Practices

1. **Naming Convention**: Use a consistent naming convention for resources
2. **Tags**: Consider adding tags for resource organization and cost tracking
3. **Security**: Use the sensitive outputs appropriately and avoid exposing access keys
4. **Backup**: For production environments, consider enabling backup and versioning
5. **Monitoring**: Set up monitoring and alerts for your storage account

## Troubleshooting

### Common Issues

1. **Storage Account Name Already Exists**: Storage account names must be globally unique
2. **Invalid Replication Type**: Premium tier only supports LRS replication
3. **Permission Issues**: Ensure your Azure account has sufficient permissions

### Validation

After deployment, verify resources:

```bash
az group show --name <resource_group_name>
az storage account show --name <storage_account_name> --resource-group <resource_group_name>
```

## Contributing

When contributing to this module:
1. Follow Terraform best practices
2. Update documentation for any changes
3. Test changes in a development environment
4. Ensure outputs are properly documented

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
