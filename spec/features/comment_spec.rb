require 'rails_helper'

RSpec.describe 'Comment', type: :feature do
  scenario 'User is able to comment on a post' do
    User.create(name: 'Josias', email: 'josiasjag@gmail.com', password: '123123')
    Post.create(user_id: 1, content: 'This is a post created for a test!')
    visit root_path
    fill_in 'user_email', with: 'josiasjag@gmail.com'
    fill_in 'user_password', with: '123123'
    click_on 'Log in'
    sleep(3)
    fill_in 'comment_content', with: 'This is a comment!'
    click_on 'Comment'
    expect(page).to have_content('This is a comment!')
  end
end
