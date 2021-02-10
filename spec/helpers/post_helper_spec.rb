require 'rails_helper'

RSpec.describe 'Friendship management', type: :feature do
  let(:user) { User.create(name: 'Youcef', email: 'youcefabdellani@gmail.com', password: 'password123') }
  let(:friend) { User.create(name: 'Cecilia', email: 'cecibenitezca@gmail.com', password: 'password123') }

  scenario 'Send friend request from Users index page' do
    friend = User.create(name: 'Cecilia', email: 'cecibenitezca@gmail.com', password: 'password123')
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')

    click_on 'All users'
    sleep(3)
    expect(page).to have_content("Name: #{friend.name}")
    expect(page).to have_button('Add friend')

    first('.btn-secondary').click # Click on the first 'Add friend' button
    sleep(3)
    expect(page).to have_content('Friend request was successfully sent.')
  end
end