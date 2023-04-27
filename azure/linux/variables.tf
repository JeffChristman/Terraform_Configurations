variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "private_key_path" {
  default     = "id_rsa"
  description = "The path to the private key for the SSH connection."
}

variable "local_file_path" {
  default     = "capture.cap"
  description = "The path to the file you want to copy to the remote virtual machine."
}

