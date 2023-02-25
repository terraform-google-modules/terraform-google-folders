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

output "ids" {
  description = "Folder ids."
  value       = module.folders.ids
}

output "names" {
  description = "Folder names."
  value       = module.folders.names
}

output "ids_list" {
  description = "List of folder ids."
  value       = module.folders.ids_list
}

output "names_list" {
  description = "List of folder names."
  value       = module.folders.names_list
}

output "per_folder_admins" {
  description = "IAM-style members per folder who will get extended permissions."
  value       = module.folders.per_folder_admins
}
