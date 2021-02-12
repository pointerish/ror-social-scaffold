require 'rails_helper'

RSpec.describe User, type: :model do
  let(:long_name) { (0...21).map { (65 + rand(26)).chr }.join }
  it 'is not valid without attributes' do
    expect(User.new).to_not be_valid
  end
  it 'is not valid when name is greater than 20 chars' do
    expect(User.new(email: 'josiasjag@gmail.com', name: long_name, gravatar_url:'simple.com')).to_not be_valid
  end
end