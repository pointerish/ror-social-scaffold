class AddFriendeeIdAsIndexInFriendships < ActiveRecord::Migration[5.2]
  def change
  end

  add_index :friendships, :friendee_id
end
