/**
 * Copyright 2023 Google LLC
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

  sub_folders1_var = compact(flatten([for k, i in var.folder_map : length(i) == 0 ? [] : [for ip1, op1 in i : join("=1>", [k, ip1])]]))

  sub_folders2_var = compact(flatten([for k, i in var.folder_map : length(i) == 0 ? [] : [for ip1, op1 in i : length(op1) == 0 ? [] : [for ip2, op2 in op1 : join("=2>", [join("=1>", [k, ip1]), ip2])]]]))

  sub_folders3_var = compact(flatten([for k, i in var.folder_map : length(i) == 0 ? [] : [for ip1, op1 in i : length(op1) == 0 ? [] : [for ip2, op2 in op1 : length(op2) == 0 ? [] : [for ip3, op3 in op2 : join("=3>", [join("=2>", [join("=1>", [k, ip1]), ip2]), ip3])]]]]))

}

module "folders" {
  source   = "../../"
  for_each = var.folder_map
  parent   = "organizations/${var.org_id}"
  names    = each.key[*]
}

module "sub_folders1" {
  source   = "../../"
  for_each = toset(local.sub_folders1_var)
  parent   = module.folders[element(split("=1>", each.value), 0)].id
  names    = [element(split("=1>", each.value), 1)]
}


module "sub_folders2" {
  source   = "../../"
  for_each = toset(local.sub_folders2_var)
  parent   = module.sub_folders1[element(split("=2>", each.value), 0)].id
  names    = [element(split("=2>", each.value), 1)]
}

module "sub_folders3" {
  source   = "../../"
  for_each = toset(local.sub_folders3_var)
  parent   = module.sub_folders2[element(split("=3>", each.value), 0)].id
  names    = [element(split("=3>", each.value), 1)]
}



