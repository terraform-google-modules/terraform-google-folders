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

module "folders" {
  source = "../.."

  parent            = "${var.parent_type}/${var.parent_id}"
  set_roles         = true
  all_folder_admins = var.all_folder_admins

  names = [
    "dev",
    "staging",
    "production",
  ]

  per_folder_admins = {
    dev = {
      members = [
        "group:test-gcp-developers@test.blueprints.joonix.net"
      ],
    },
    staging = {
      members = [
        "group:test-gcp-qa@test.blueprints.joonix.net",
      ],
    }
    production = {
      members = [
        "group:test-gcp-ops@test.blueprints.joonix.net",
      ],
    }
  }
}

