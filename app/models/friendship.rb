class SelfFriendshipValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base].push("Error! You are not supposed to befriend yourself.") if record.user_id == record.friendee_id
  end
end

class Friendship < ApplicationRecord
  include ActiveModel::Validations

  validates_with SelfFriendshipValidator

  validates :status, presence: true
  validates :user_id, presence: true
  validates :friendee_id, presence: true

  belongs_to :user, foreign_key: "user_id", class_name: "User"
  belongs_to :user, foreign_key: "friendee_id", class_name: "User"

  scope :confirmed_friends, ->(user_id) { where("user_id = ? AND status = 'confirmed'", user_id) }
  scope :pending_invites_by_me, ->(user_id) { where("user_id = ? AND status = 'pending'", user_id) }
  scope :pending_invites_to_me, ->(user_id) { where("friendee_id = ? AND status = 'pending'", user_id) }

  # def confirm_friend
  #  create(friendee_id: user_id, user_id: friendee_id, status: 'confirmed')
  # end
end
