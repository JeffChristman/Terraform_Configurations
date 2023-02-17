terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0"
    }
  }
}
provider "azurerm" {
  features {}

  subscription_id = "be9a1fbd-6055-450e-9f93-e817e7c4570a"
  tenant_id = "795e28b4-8802-4721-9a2e-c81f108d8536"
  client_id =  "885d90fe-1dd7-4171-aa56-892e5d0e9e7f"
  client_secret = "7Bu8Q~Bu_aJM6CAFL2GuRrkfdEnL2JmnfEDSDcRa"

}

