class User < ApplicationRecord
  has_many :user_genres, dependent: :delete_all
  has_many :user_instruments, dependent: :delete_all
  has_many :user_question_details, dependent: :delete_all
  has_many :genres, through: :user_genres
  has_many :instruments, through: :user_instruments
  has_many :likes, dependent: :delete_all
  has_one_attached :avatar
  

  has_secure_password
end
