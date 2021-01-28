class Friendship < ApplicationRecord
  validates :status, presence: true
  validates :user_id, presence: true
  validates :friendee_id, presence: true

  belongs_to :user, foreign_key: "friendee_id", class_name: "User"
end
