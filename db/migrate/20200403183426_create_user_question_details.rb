class CreateUserQuestionDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :user_question_details do |t|
      t.string :match_instrument
      t.string :match_genre
      t.string :match_level
      t.string :match_goal
      t.integer :min_age
      t.integer :max_age
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
