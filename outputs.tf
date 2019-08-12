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

output "folders" {
  description = "Folder resources."
  value       = google_folder.folders
}

output "id" {
  description = "Folder id (single-use case)."
  value       = google_folder.folders[0].name
}

output "ids" {
  description = "Folder ids."
  value       = google_folder.folders[*].name
}

output "name" {
  description = "Folder name (single-use case)."
  value       = google_folder.folders[0].display_name
}

output "names" {
  description = "Folder names."
  value       = google_folder.folders[*].display_name
}
