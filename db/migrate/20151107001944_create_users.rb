class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.integer :company_id
    	t.string :first_name
    	t.string :last_name
    	t.string :email
    	t.integer :phone
    	t.string :location
    	
      t.timestamps null: false
    end
  end
end
