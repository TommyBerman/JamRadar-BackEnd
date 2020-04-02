class User < ApplicationRecord
  has_many :user_genres, class_name: "user_genre", foreign_key: "reference_id"
  has_many :user_instruments, class_name: "user_instrument", foreign_key: "reference_id"
  has_many :genres, through: :user_genres
  has_many :instruments, through: :user_instruments

  has_secure_passowrd
end
