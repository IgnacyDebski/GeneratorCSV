class DeleteUnusedFieldsFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :name
    remove_column :users, :password
    remove_column :users, :password_digest
  end
end
