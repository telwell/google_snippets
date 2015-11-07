class CreateProjectsUsers < ActiveRecord::Migration
  def change
    create_table :projects_users do |t|
    	t.integer :project_id, null: false
    	t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :projects_users, :project_id
    add_index :projects_users, :user_id
  end
end
