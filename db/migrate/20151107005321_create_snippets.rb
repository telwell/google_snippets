class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
    	t.integer :user_id, null: false
    	t.integer :project_id, null: false
    	t.string :text, null: false

      t.timestamps null: false
    end

    add_index :snippets, :user_id
    add_index :snippets, :project_id

  end
end
