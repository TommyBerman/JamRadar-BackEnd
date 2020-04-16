class AddBandNameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :band_name, :string
  end
end
