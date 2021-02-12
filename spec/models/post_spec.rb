require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:long_content) { (0...1001).map { (65 + rand(26)).chr }.join }
  it 'is not valid without attributes' do
    expect(Post.new).to_not be_valid
  end
  it 'is not valid when name is greater than 200 chars' do
    expect(Post.new(content: long_content)).to_not be_valid
  end
end