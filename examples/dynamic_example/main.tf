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

  sub_folders1_var = compact(flatten([for k, i in var.folder_list : i == [] ? [] : [for ip1, op1 in i : join("=1>", [k, ip1])]]))

  sub_folders2_var = compact(flatten([for k, i in var.folder_list : i == [] ? [] : [for ip1, op1 in i : op1 == [] ? [] : [for ip2, op2 in op1 : join("=2>", [join("=1>", [k, ip1]), ip2])]]]))

  sub_folders3_var = compact(flatten([for k, i in var.folder_list : i == [] ? [] : [for ip1, op1 in i : op1 == [] ? [] : [for ip2, op2 in op1 : op2 == [] ? [] : [for ip3, op3 in op2 : join("=3>", [join("=2>", [join("=1>", [k, ip1]), ip2]), ip3])]]]]))

  sub_folders4_var = compact(flatten([for k, i in var.folder_list : i == [] ? [] : [for ip1, op1 in i : op1 == [] ? [] : [for ip2, op2 in op1 : op2 == [] ? [] : [for ip3, op3 in op2 : op3 == [] ? [] : [for ip4, op4 in op3 : join("=4>", [join("=3>", [join("=2>", [join("=1>", [k, ip1]), ip2]), ip3]), ip4])]]]]]))

  sub_folders5_var = compact(flatten([for k, i in var.folder_list : i == [] ? [] : [for ip1, op1 in i : op1 == [] ? [] : [for ip2, op2 in op1 : op2 == [] ? [] : [for ip3, op3 in op2 : op3 == [] ? [] : [for ip4, op4 in op3 : op4 == [] ? [] : [for ip5, op5 in op4 : join("=5>", [join("=4>", [join("=3>", [join("=2>", [join("=1>", [k, ip1]), ip2]), ip3]), ip4]), ip5])]]]]]]))

  sub_folders6_var = compact(flatten([for k, i in var.folder_list : i == [] ? [] : [for ip1, op1 in i : op1 == [] ? [] : [for ip2, op2 in op1 : op2 == [] ? [] : [for ip3, op3 in op2 : op3 == [] ? [] : [for ip4, op4 in op3 : op4 == [] ? [] : [for ip5, op5 in op4 : op5 == [] ? [] : [for ip6, op6 in op5 : join("=6>", [join("=5>", [join("=4>", [join("=3>", [join("=2>", [join("=1>", [k, ip1]), ip2]), ip3]), ip4]), ip5]), ip6])]]]]]]]))

  sub_folders7_var = compact(flatten([for k, i in var.folder_list : i == [] ? [] : [for ip1, op1 in i : op1 == [] ? [] : [for ip2, op2 in op1 : op2 == [] ? [] : [for ip3, op3 in op2 : op3 == [] ? [] : [for ip4, op4 in op3 : op4 == [] ? [] : [for ip5, op5 in op4 : op5 == [] ? [] : [for ip6, op6 in op5 : op6 == [] ? [] : [for ip7, op7 in op6 : join("=7>", [join("=6>", [join("=5>", [join("=4>", [join("=3>", [join("=2>", [join("=1>", [k, ip1]), ip2]), ip3]), ip4]), ip5]), ip6]), ip7])]]]]]]]]))

  sub_folders8_var = compact(flatten([for k, i in var.folder_list : i == [] ? [] : [for ip1, op1 in i : op1 == [] ? [] : [for ip2, op2 in op1 : op2 == [] ? [] : [for ip3, op3 in op2 : op3 == [] ? [] : [for ip4, op4 in op3 : op4 == [] ? [] : [for ip5, op5 in op4 : op5 == [] ? [] : [for ip6, op6 in op5 : op6 == [] ? [] : [for ip7, op7 in op6 : op7 == [] ? [] : [for ip8, op8 in op7 : join("=8>", [join("=7>", [join("=6>", [join("=5>", [join("=4>", [join("=3>", [join("=2>", [join("=1>", [k, ip1]), ip2]), ip3]), ip4]), ip5]), ip6]), ip7]), ip8])]]]]]]]]]))

  sub_folders9_var = compact(flatten([for k, i in var.folder_list : i == [] ? [] : [for ip1, op1 in i : op1 == [] ? [] : [for ip2, op2 in op1 : op2 == [] ? [] : [for ip3, op3 in op2 : op3 == [] ? [] : [for ip4, op4 in op3 : op4 == [] ? [] : [for ip5, op5 in op4 : op5 == [] ? [] : [for ip6, op6 in op5 : op6 == [] ? [] : [for ip7, op7 in op6 : op7 == [] ? [] : [for ip8, op8 in op7 : op8 == [] ? [] : [for ip9, op9 in op8 : join("=9>", [join("=8>", [join("=7>", [join("=6>", [join("=5>", [join("=4>", [join("=3>", [join("=2>", [join("=1>", [k, ip1]), ip2]), ip3]), ip4]), ip5]), ip6]), ip7]), ip8]), ip9])]]]]]]]]]]))


}

module "folders" {
  source   = "../../"
  for_each = var.folder_list
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

module "sub_folders4" {
  source   = "../../"
  for_each = toset(local.sub_folders4_var)
  parent   = module.sub_folders3[element(split("=4>", each.value), 0)].id
  names    = [element(split("=4>", each.value), 1)]
}


module "sub_folders5" {
  source   = "../../"
  for_each = toset(local.sub_folders5_var)
  parent   = module.sub_folders4[element(split("=5>", each.value), 0)].id
  names    = [element(split("=5>", each.value), 1)]
}

module "sub_folders6" {
  source   = "../../"
  for_each = toset(local.sub_folders6_var)
  parent   = module.sub_folders5[element(split("=6>", each.value), 0)].id
  names    = [element(split("=6>", each.value), 1)]
}

module "sub_folders7" {
  source   = "../../"
  for_each = toset(local.sub_folders7_var)
  parent   = module.sub_folders6[element(split("=7>", each.value), 0)].id
  names    = [element(split("=7>", each.value), 1)]
}

module "sub_folders8" {
  source   = "../../"
  for_each = toset(local.sub_folders8_var)
  parent   = module.sub_folders7[element(split("=8>", each.value), 0)].id
  names    = [element(split("=8>", each.value), 1)]
}

module "sub_folders9" {
  source   = "../../"
  for_each = toset(local.sub_folders9_var)
  parent   = module.sub_folders8[element(split("=9>", each.value), 0)].id
  names    = [element(split("=9>", each.value), 1)]
}


