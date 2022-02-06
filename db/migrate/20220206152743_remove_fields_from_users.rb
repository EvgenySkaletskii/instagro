class RemoveFieldsFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_columns(:users, :first_name, :last_name, :nickname)
    add_column :users, :full_name, :string
  end
end
