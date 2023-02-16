# Resource Hierarchy Folder Creation

This Terraform code will create dynamic Resource Heirachy Folder structure under your Organization Node in your GCP environment.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| folder\_list | Mention the folder structure | `any` | n/a | yes |
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
