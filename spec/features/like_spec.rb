require 'rails_helper'

RSpec.describe 'Like', type: :feature do
  scenario 'User is able to like a post' do
    User.create(name: 'Josias', email: 'josiasjag@gmail.com', password: '123123')
    Post.create(user_id: 1, content: 'This is a post created for a test!')
    visit root_path
    fill_in 'user_email', with: 'josiasjag@gmail.com'
    fill_in 'user_password', with: '123123'
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Like!')
  end
end
