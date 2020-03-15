class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password_digest
      t.string :email
      t.integer :house_number
      t.string :street
      t.integer :flat_number
      t.string :city
      t.string :postcode
      t.string :position
      t.string :experience_level
      t.string :aspiration

      t.timestamps
    end
  end
end
