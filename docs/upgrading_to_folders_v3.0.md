# Upgrading to Folders v3.0 (from v2.X)

The v3.0 release of the Folders module is a backwards incompatible release, due to the following breaking changes:

- the `per_folder_admins` variable is of type `map(string)`, see [Readme](../Readme.md#Usage) for usage
- module uses for_each instead of count
- minimum Terraform version increased to 0.13
- minimum provider version increased to 3.45

## Migration Instructions

A migration from 2.x to 3.x as showcased below

```diff
module "folders" {
   source  = "terraform-google-modules/folders/google"
-  version = "2.0.2"
+  version = "~> 3.0"

  parent  = "folders/65552901371"

  names = [
    "dev",
    "staging",
    "production",
  ]

  set_roles = true

  per_folder_admins =
-  [
-    "group:gcp-developers@domain.com",
-    "group:gcp-qa@domain.com",
-    "group:gcp-ops@domain.com",
-  ]
+ {
+    dev = "group:gcp-developers@domain.com"
+    staging = "group:gcp-qa@domain.com"
+    production = "group:gcp-ops@domain.com"
+ }

  all_folder_admins = [
    "group:gcp-security@domain.com",
  ]
}
```
will produce the following output during plan:

```bash
module.folders.google_folder.folders will be destroyed
module.folders.google_folder.folders[1] will be destroyed
module.folders.google_folder.folders[2] will be destroyed
module.folders.google_folder_iam_binding.owners will be destroyed
module.folders.google_folder_iam_binding.owners[1] will be destroyed
  .
  .
module.folders.google_folder_iam_binding.owners[11] will be destroyed

module.folders.google_folder.folders["dev"] will be created
module.folders.google_folder.folders["production"] will be created
module.folders.google_folder.folders["staging"] will be created
module.folders.google_folder_iam_binding.owners["dev-roles/compute.networkAdmin"] will be created
module.folders.google_folder_iam_binding.owners["dev-roles/owner"] will be created
  .
  .
module.folders.google_folder_iam_binding.owners["staging-roles/resourcemanager.projectCreator"] will be created
Plan: 15 to add, 0 to change, 15 to destroy.
  ```

To prevent folder recreation, it is recommended to migrate the statefile as shown below

```shell
terraform state mv module.folders.google_folder.folders[0] 'module.folders.google_folder.folders["dev"]'
terraform state mv module.folders.google_folder.folders[1] 'module.folders.google_folder.folders["staging"]'
terraform state mv module.folders.google_folder.folders[2] 'module.folders.google_folder.folders["production"]'
```

Re running the plan should show that the folder resources are no longer targeted.


IAM roles maybe temporarily destroyed and reapplied, this is a safe operation. However, the same migration stategy as above can be used if necessary.
Example:

```shell
terraform state mv module.folders.google_folder_iam_binding.owners[0] 'module.folders.google_folder_iam_binding.owners["dev-roles/owner"]'
```
