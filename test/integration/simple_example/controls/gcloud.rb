# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

control "gcloud" do
  title "gcloud"

  describe command("gcloud resource-manager folders list --folder=#{attribute("parent").split('/')[1]}") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should include "#{attribute("names")[0]}" }
    its(:stdout) { should include "#{attribute("names")[1]}" }
    its(:stdout) { should include "#{attribute("names")[2]}" }
  end

  folder_names = attribute("names")
  folder_names_and_ids   = attribute("names_and_ids")
  per_folder_admins = attribute("per_folder_admins")

  folder_id = folder_names_and_ids[folder_names[0]]
  folder_admin = per_folder_admins[0]
  describe command("gcloud alpha resource-manager folders get-iam-policy #{folder_id}") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should include "#{attribute("per_folder_admins")[0]}" }
  end


  folder_id = folder_names_and_ids[folder_names[1]]
  folder_admin = per_folder_admins[1]
  describe command("gcloud alpha resource-manager folders get-iam-policy #{folder_id}") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should include "#{attribute("per_folder_admins")[1]}" }
  end

  folder_id = folder_names_and_ids[folder_names[2]]
  folder_admin = per_folder_admins[2]
  describe command("gcloud alpha resource-manager folders get-iam-policy #{folder_id}") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should include "#{attribute("per_folder_admins")[2]}" }
  end

end