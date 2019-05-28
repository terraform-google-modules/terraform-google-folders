# Simple Example

This example illustrates how to use the `folders` module.

[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| all\_folder\_admins | List of comma delimited IAM-style members that will get the extended permissions across all the folders. | list | `<list>` | no |
| names | Folder names. | list | `<list>` | no |
| parent\_id | Id of the resource under which the folder will be placed. | string | n/a | yes |
| parent\_type | Type of the parent reosurce, defaults to organization. | string | `"organization"` | no |
| per\_folder\_admins | List of comma delimited IAM-style members per folder who will get extended permissions. | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| ids | Map of name => folder resource id. |

[^]: (autogen_docs_end)

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
