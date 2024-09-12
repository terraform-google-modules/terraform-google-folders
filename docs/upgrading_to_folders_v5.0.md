# Upgrading to v5.0

The v5.0 release of the *Folders* module is a backwards incompatible release.

### Google Cloud Platform Provider upgrade
The *Folders* module now requires version 6.0 or higher of the Google Cloud Platform Providers.

```diff
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
-      version = "~> 5.0"
+      version = "~> 6.0"
    }
  }
}
```

### Deletion Protection
The *Folders* Module now includes the `deletion_protection` option which defaults to `true`.  To delete your folders using Terraform, you should specify it explicitly to `false`:

```diff
  module "gke" {
-   source  = "terraform-google-modules/folders/google"
-   version = "~> 4.0"
+   source  = "terraform-google-modules/folders/google"
+   version = "~> 5.0"
...
+   deletion_protection = false
}
```
