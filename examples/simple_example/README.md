# Simple Example

This example illustrates how to use the `folders` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| all\_folder\_admins | List of IAM-style members that will get the extended permissions across all the folders. | `list(string)` | `[]` | no |
| names | Folder names. | `list(string)` | `[]` | no |
| parent\_id | Id of the resource under which the folder will be placed. | `string` | n/a | yes |
| parent\_type | Type of the parent resource. One of `organizations` or `folders`. | `string` | `"folders"` | no |
| per\_folder\_admins | IAM-style members per folder who will get extended permissions. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| ids | Folder ids. |
| ids\_list | List of folder ids. |
| names | Folder names. |
| names\_list | List of folder names. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
