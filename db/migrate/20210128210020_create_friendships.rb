class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friendee_id
      t.boolean :status

      t.timestamps
    end
    add_index :friendships, :user_id
  end
end
