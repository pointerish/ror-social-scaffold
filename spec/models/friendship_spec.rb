require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it 'is not valid without attributes' do
    expect(Friendship.new).to_not be_valid
  end
  it 'is not valid when user_id is missing' do
    expect(Friendship.new(friendee_id: 1, status: false)).to_not be_valid
  end
  it 'is not valid when friendee_id is missing' do
    expect(Friendship.new(user_id: 1, status: false)).to_not be_valid
  end
  it 'is not valid when status is missing' do
    expect(Friendship.new(user_id: 1, friendee_id: 2)).to_not be_valid
  end
end