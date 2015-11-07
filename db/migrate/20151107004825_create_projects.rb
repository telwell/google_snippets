class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
    	t.integer :parent_id, null: false
    	t.integer :company_id, null: false
    	t.string :name, null: false
    	t.string :description

      t.timestamps null: false
    end
    
    add_index :projects, :company_id
  	add_index :projects, :parent_id
  end

end
