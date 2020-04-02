class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :email
      t.integer :age
      t.string :gender
      t.string :hometown
      t.string :level
      t.string :goal
      t.string :purpose

      t.timestamps
    end
  end
end
