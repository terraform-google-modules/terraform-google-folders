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

  describe command("gcloud resource-manager folders list --folder=#{attribute("parent_id")}") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should include "#{attribute("names").values[0]}" }
    its(:stdout) { should include "#{attribute("names").values[1]}" }
    its(:stdout) { should include "#{attribute("names").values[2]}" }
  end

  folder_names_list = attribute("names_list")
  folder_ids = attribute("ids_list")
  per_folder_admins = attribute("per_folder_admins")

  (0..2).each do |i|
    describe command("gcloud alpha resource-manager folders get-iam-policy #{folder_ids[i]}") do
      its(:exit_status) { should eq 0 }
      its(:stderr) { should eq "" }
      its(:stdout) { should include per_folder_admins[folder_names_list[i].to_sym] }
    end
  end

end
