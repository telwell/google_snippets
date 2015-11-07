class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.attachment :photo

      t.timestamps null: false
    end

    add_column :users, :avatar_id, :integer
  end
end
