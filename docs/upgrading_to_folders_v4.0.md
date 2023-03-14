# Upgrading to Folders v4.0 (from v3.X)

The v4.0 release of the Folders module is a backwards incompatible release, due to the following breaking changes:

- the `per_folder_admins` variable is of type `map(object({
    members = list(string)
    roles   = optional(list(string))
  }))`, see [Readme](../Readme.md#Usage) for usage
- minimum Terraform version increased to 1.3

## Migration Instructions

A migration from 3.x to 4.0 as showcased below

```diff
module "folders" {
   source  = "terraform-google-modules/folders/google"
-  version = "~> 3.0"
+  version = "~> 4.0"

  parent  = "folders/65552901371"

  names = [
    "dev",
    "staging",
    "production",
  ]

  set_roles = true

  per_folder_admins =
- {
-    dev = "group:gcp-developers@domain.com"
-    staging = "group:gcp-qa@domain.com"
-    production = "group:gcp-ops@domain.com"
- }

+ {
+    dev = {
+      members = [
+        "group:test-gcp-developers@test.blueprints.joonix.net"
+      ],
+    },
+    staging = {
+      members = [
+        "group:test-gcp-qa@test.blueprints.joonix.net",
+      ],
+    }
+    production = {
+      members = [
+        "group:test-gcp-ops@test.blueprints.joonix.net",
+      ],
+    }
+ }

  all_folder_admins = [
    "group:gcp-security@domain.com",
  ]
}
```
Running this will produce slight changes to the outputs but will make no change to the resources:

```bash
Changes to Outputs:
  ~ per_folder_admins = {
      - "dev"        = "group:test-gcp-developers@test.blueprints.joonix.net"
      - "production" = "group:test-gcp-ops@test.blueprints.joonix.net"
      - "staging"    = "group:test-gcp-qa@test.blueprints.joonix.net"
    } -> {
      + dev        = "group:test-gcp-developers@test.blueprints.joonix.net"
      + production = "group:test-gcp-ops@test.blueprints.joonix.net"
      + staging    = "group:test-gcp-qa@test.blueprints.joonix.net"
```
