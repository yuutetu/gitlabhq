class AddCoverageSettingToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :coverage_enabled, :boolean
    add_column :projects, :coverage_url, :string
    add_column :projects, :coverage_base_path, :string
    add_column :projects, :coverage_parse_type, :string
  end
end
