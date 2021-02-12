# rubocop:disable Style/GuardClause

class SelfFriendshipValidator < ActiveModel::Validator
  def validate(record)
    if record.user_id == record.friendee_id
      record.errors[:base].push('Error! You are not supposed to befriend yourself.')
    end
  end
end

class Friendship < ApplicationRecord
  include ActiveModel::Validations

  validates_with SelfFriendshipValidator

  validates :status, presence: true
  validates :user_id, presence: true
  validates :friendee_id, presence: true

  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
  belongs_to :user, foreign_key: 'friendee_id', class_name: 'User'
end

# rubocop:enable Style/GuardClause
