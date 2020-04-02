class Instrument < ApplicationRecord
    has_many :user_instruments, class_name: "user_genre", foreign_key: "reference_id"
    has_many :users, through: :user_instruments
end
