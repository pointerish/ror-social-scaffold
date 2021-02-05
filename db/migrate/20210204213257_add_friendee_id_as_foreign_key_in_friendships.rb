class AddFriendeeIdAsForeignKeyInFriendships < ActiveRecord::Migration[5.2]
  def change
  end

  add_foreign_key :friendships, :users, column: :friendee_id, primary_key: "id"
end
