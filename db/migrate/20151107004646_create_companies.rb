class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
    	t.string :name, null: false 
    	t.integer :admin_id

      t.timestamps null: false
    end
  end
end
