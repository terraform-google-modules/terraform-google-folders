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

  name_role_pairs = setproduct(var.names, var.folder_admin_roles)
  folder_admin_roles_map_data = zipmap(
    [for pair in local.name_role_pairs : "${pair[0]}-${pair[1]}"],
    [for pair in local.name_role_pairs : {
      name = pair[0]
      role = pair[1]
    }]
  )
}

resource "google_folder" "folders" {
  for_each = toset(var.names)

  display_name = "${local.prefix}${each.value}"
  parent       = var.parent
}

# give project creation access to service accounts
# https://cloud.google.com/resource-manager/docs/access-control-folders#granting_folder-specific_roles_to_enable_project_creation

resource "google_folder_iam_binding" "owners" {
  for_each = var.set_roles ? local.folder_admin_roles_map_data : {}
  folder   = google_folder.folders[each.value.name].name
  role     = each.value.role

  members = compact(
    concat(
      split(",",
        lookup(var.per_folder_admins, each.value.name, ""),
      ),
      var.all_folder_admins,
    ),
  )
}
