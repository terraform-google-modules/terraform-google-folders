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

  # Data structured for google_folder_iam_binding (per folder + role binding)
  # Only create data if roles are set and there are combined roles
  folder_iam_bindings_data = var.set_roles && length(local.folder_admin_roles_combined) > 0 ? {
    for i, role_map in local.folder_admin_roles_combined :
    # Use folder name and role for a unique key for bindings
    "${role_map.name}-${role_map.role}" => role_map
  } : {}

  # Data structured for google_folder_iam_member (per folder + role + member)
  # Only create data if roles are set and there are combined roles
  folder_iam_member_entries = flatten([
    for role_map in local.folder_admin_roles_combined : [
      for member in role_map.members : {
        # Create a unique key combining folder, role, and a hash of the member
        # SHA1 helps handle complex member strings like service account emails
        key         = "${role_map.name}-${role_map.role}-${sha1(member)}"
        folder_name = role_map.name
        role        = role_map.role
        member      = member
      }
    ]
  ])
}


resource "google_folder" "folders" {
  for_each = toset(var.names)

  display_name        = "${local.prefix}${each.value}"
  parent              = var.parent
  deletion_protection = var.deletion_protection
}

# give project creation access to service accounts
# https://cloud.google.com/resource-manager/docs/access-control-folders#granting_folder-specific_roles_to_enable_project_creation

# Use google_folder_iam_binding when mode is "authoritative"
resource "google_folder_iam_binding" "owners_combined" {
  # Create this resource only if mode is authoritative and there is data
  for_each = var.mode == "authoritative" ? local.folder_iam_bindings_data : {}

  # Resolve the folder ID using the folder name from the local
  folder = google_folder.folders[each.value.name].name
  role   = each.value.role

  # Use the calculated list of members for this binding
  # The distinct/flatten logic from the original binding resource
  # is now implicitly handled by how local.folder_admin_roles_combined is built
  # and flattened in folder_iam_bindings_data.
  members = each.value.members
}

# Use google_folder_iam_member when mode is "additive"
resource "google_folder_iam_member" "owner_member" {
  # Create this resource only if mode is additive and there is data
  for_each = var.mode == "additive" && length(local.folder_iam_member_entries) > 0 ? {
    for entry in local.folder_iam_member_entries :
    entry.key => entry
  } : {}

  # Resolve the folder ID using the folder name from the local entry
  folder = google_folder.folders[each.value.folder_name].name
  role   = each.value.role
  member = each.value.member
}