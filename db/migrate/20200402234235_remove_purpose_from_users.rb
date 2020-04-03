class RemovePurposeFromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :purpose, :string
  end
end
