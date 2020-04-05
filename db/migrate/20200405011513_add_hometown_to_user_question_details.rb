class AddHometownToUserQuestionDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :user_question_details, :hometown, :string
  end
end
