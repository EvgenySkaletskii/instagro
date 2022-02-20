class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.bigint :user_id
      t.bigint :likable_id
      t.string :likable_type
      t.timestamps
    end
    add_index :likes, [:likable_type, :likable_id]
  end
end
