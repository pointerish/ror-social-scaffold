require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let(:user) { User.create(name: 'Josias', email: 'josiasjag@gmail.com', password: '123123') }
  let(:friendee) { User.create(name: 'Lorena', email: 'anerlo@gmail.com', password: '123123') }

  scenario 'User is able to sign in' do
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')
  end
  scenario 'User is not able to sign in' do
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: '123124'
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Invalid Email or password.')
  end
end