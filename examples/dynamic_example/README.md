# Resource Hierarchy Folder Creation

This Terraform code will create dynamic resource hierarchy folder structure under your Organization node in your GCP environment.

## Sample tfvars file

```hcl
#terraform.tfvars
org_id = "xxxxxxxxxxx"
folder_map = {
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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| folder\_map | Folder structure as a map | `any` | n/a | yes |
| org\_id | The Organization Id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| folder\_ids | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
