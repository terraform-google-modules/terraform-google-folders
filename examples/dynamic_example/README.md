# Resource Hierarchy Folder Creation

This Terraform code will create dynamic Resource Heirachy Folder structure under your Organization Node in your GCP environment.

## Sample code
```hcl

#terraform.tfvars

org_id = "xxxxxxxxxxx"
folder_list = {
              "Accounts" : {
                             "Dev1" : [],
                             "Dev2" : {
                                      "DevA" : []
                                      }
                           },
              "Sales" : {
                          "Dev1" : []
                        }
              }
                 


```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.50 |


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_folders"></a> [folders](#module\_folders) | terraform-google-modules/folders/google | ~> 3.0 |
| <a name="module_sub_folders1"></a> [sub\_folders1](#module\_sub\_folders1) | terraform-google-modules/folders/google | ~> 3.0 |
| <a name="module_sub_folders2"></a> [sub\_folders2](#module\_sub\_folders2) | terraform-google-modules/folders/google | ~> 3.0 |
| <a name="module_sub_folders3"></a> [sub\_folders3](#module\_sub\_folders3) | terraform-google-modules/folders/google | ~> 3.0 |
| <a name="module_sub_folders4"></a> [sub\_folders4](#module\_sub\_folders4) | terraform-google-modules/folders/google | ~> 3.0 |
| <a name="module_sub_folders5"></a> [sub\_folders5](#module\_sub\_folders5) | terraform-google-modules/folders/google | ~> 3.0 |
| <a name="module_sub_folders6"></a> [sub\_folders6](#module\_sub\_folders6) | terraform-google-modules/folders/google | ~> 3.0 |
| <a name="module_sub_folders7"></a> [sub\_folders7](#module\_sub\_folders7) | terraform-google-modules/folders/google | ~> 3.0 |
| <a name="module_sub_folders8"></a> [sub\_folders8](#module\_sub\_folders8) | terraform-google-modules/folders/google | ~> 3.0 |
| <a name="module_sub_folders9"></a> [sub\_folders9](#module\_sub\_folders9) | terraform-google-modules/folders/google | ~> 3.0 |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_folder_list"></a> [folder\_list](#input\_folder\_list) | Mention the folder structure | `any` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The Organization Id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_folder_ids"></a> [folder\_ids](#output\_folder\_ids) | n/a |
