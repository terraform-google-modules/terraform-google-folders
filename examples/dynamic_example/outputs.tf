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

output "folder_ids" {
  value = [[for k, v in var.folder_list : module.folders[k].ids], [for i in local.sub_folders1_var : module.sub_folders1[i].ids], [for j in local.sub_folders2_var : module.sub_folders2[j].ids], [for l in local.sub_folders3_var : module.sub_folders3[l].ids], [for m in local.sub_folders4_var : module.sub_folders4[m].ids], [for m in local.sub_folders5_var : module.sub_folders5[m].ids], [for m in local.sub_folders6_var : module.sub_folders6[m].ids], [for m in local.sub_folders7_var : module.sub_folders7[m].ids], [for m in local.sub_folders8_var : module.sub_folders8[m].ids], [for m in local.sub_folders9_var : module.sub_folders9[m].ids]]
}
