class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    #to get all posts for a specific user
    add_index :posts, [:user_id, :created_at]
  end
end
