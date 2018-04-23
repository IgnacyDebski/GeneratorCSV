class AddTrelloFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :trello_id, :string
    add_column :users, :trello_username, :string
    add_column :users, :trello_access_token, :string
    add_column :users, :trello_secret_token, :string
  end
end
