/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  prefix       = var.prefix == "" ? "" : "${var.prefix}-"
  folders_list = [for name in var.names : try(google_folder.folders[name], "")]
  first_folder = try(local.folders_list[0], {})

  # Handle roles for per_folder_admins if provided
  folder_admin_roles_map_data = flatten([
    for name, config in var.per_folder_admins : [
      for role in config.roles != null ? config.roles : var.folder_admin_roles : {
        name    = name,
        role    = role,
        members = config.members
      }
    ]
  ])

  # Handle roles for all_folder_admins if provided, applied to all folders only if they are not part of per_folder_admins
  folder_admin_roles_all_folders = flatten([
    for folder in var.names : [
      for role in var.folder_admin_roles : {
        name    = folder,
        role    = role,
        members = var.all_folder_admins
      }
    ]
    # Only add roles for all_folder_admins if they are not already present in per_folder_admins
    if length(var.all_folder_admins) > 0 && !contains(keys(var.per_folder_admins), folder)
  ])

  # Merge per_folder_admins and all_folder_admins, avoiding duplication
  folder_admin_roles_combined = [
    for role_map in concat(local.folder_admin_roles_map_data, local.folder_admin_roles_all_folders) : role_map
  ]
}

resource "google_folder" "folders" {
  for_each = toset(var.names)

  display_name        = "${local.prefix}${each.value}"
  parent              = var.parent
  deletion_protection = var.deletion_protection
  tags                = var.tags
}

# give project creation access to service accounts
# https://cloud.google.com/resource-manager/docs/access-control-folders#granting_folder-specific_roles_to_enable_project_creation

locals {
  folder_iam_bindings = var.set_roles && length(local.folder_admin_roles_combined) > 0 ? { for i, role in local.folder_admin_roles_combined : "${role.name}-${role.role}" => role } : {}
}

resource "google_folder_iam_binding" "owners_combined" {
  for_each = local.folder_iam_bindings

  folder = google_folder.folders[each.value.name].name
  role   = each.value.role

  members = distinct(flatten([
    each.value.members,
    length(var.all_folder_admins) > 0 && contains(var.names, each.value.name) ? var.all_folder_admins : []
  ]))
}
