class Genre < ApplicationRecord
    has_many :user_genres, class_name: "user_genre", foreign_key: "reference_id"
    has_many :users, through: :user_genres
end
