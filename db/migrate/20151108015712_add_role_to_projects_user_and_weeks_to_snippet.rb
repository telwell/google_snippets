class AddRoleToProjectsUserAndWeeksToSnippet < ActiveRecord::Migration
  def change
  	add_column :projects_users, :role, :string
  	add_column :snippets, :week, :string
  end
end
