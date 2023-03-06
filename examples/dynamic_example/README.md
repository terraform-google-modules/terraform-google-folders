# Resource Hierarchy Folder Creation

This Terraform code will create dynamic resource hierarchy folder structure under your Organization node in your GCP environment.

## Sample tfvars file

```hcl
#terraform.tfvars
org_id = "xxxxxxxxxx"
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

## Scale up the levels of sub-folders

Given code can create 3 levels of sub-folders under the main folder.

To scale up from 3 to 4 levels of sub-folders, follow below mentioned steps.

Add a new variable in the local block.

```hcl
sub_folders4_var = compact(flatten([for k, i in var.folder_map : length(i) == 0 ? [] : [for ip1, op1 in i : length(op1) == 0 ? [] : [for ip2, op2 in op1 : length(op2) == 0 ? [] : [for ip3, op3 in op2 : length(op3) == 0 ? [] : [for ip4, op4 in op3 : join("=4>", [join("=3>", [join("=2>", [join("=1>", [k, ip1]), ip2]), ip3]), ip4])]]]]]))
```

Note: `n` level of vars contain `n+1` of `for` loop, `n` of `if condition` and `n` of `join` functions.

Add a new module block.

```hcl
module "sub_folders4" {
  source   = "../../"
  for_each = toset(local.sub_folders4_var)
  parent   = module.sub_folders3[element(split("=4>", each.value), 0)].id
  names    = [element(split("=4>", each.value), 1)]
}

```

Add the `[for m in local.sub_folders4_var : module.sub_folders4[m].ids]` in output variable

Note: Upto 10 level of subfolders creation is possible in GCP.
