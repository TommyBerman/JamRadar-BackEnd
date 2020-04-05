class User < ApplicationRecord
  has_many :user_genres
  has_many :user_instruments
  has_many :user_question_details
  has_many :genres, through: :user_genres
  has_many :instruments, through: :user_instruments
  

  has_secure_password
end
