class AddIndexToLikes < ActiveRecord::Migration[6.0]
  def change
    add_index :likes, [:user_id, :liked_user], :unique => true
  end
end
