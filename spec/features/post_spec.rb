require 'rails_helper'
require 'pry'

RSpec.describe 'Post', type: :feature do
  let(:user) { User.create(name: 'Josias', email: 'josiasjag@gmail.com', password: '123123') }
  let(:friendee) { User.create(name: 'Lorena', email: 'anerlo@gmail.com', password: '123123') }
  let(:non_friendee) { User.create(name: 'Gloria', email: 'gloria@gmail.com', password: '123123') }
  let(:friendship) { user.build(friendee_id: 2, status: 'confirmed') }

  scenario 'User is able to publish new post' do
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    sleep(3)
    fill_in 'post_content', with: 'A post by Josias'
    click_on 'Save'
    sleep(3)
    expect(page).to have_content('Post was successfully created.')
  end

  scenario 'User is not able to publish new post' do
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    sleep(3)
    visit '/posts'
    sleep(3)
    fill_in 'post_content', with: (0...1001).map { rand(65..90).chr }.join
    click_on 'Save'
    sleep(3)
    expect(page).to have_content('Post could not be saved')
  end

  scenario 'User is able to see its friend\'s posts' do
    User.create(name: 'Josias', email: 'josiasjag@gmail.com', password: '123123')
    User.create(name: 'Lorena', email: 'anerlo@gmail.com', password: '123123')
    Friendship.create(user_id: 1, friendee_id: 2, status: 'confirmed')
    visit root_path
    fill_in 'user_email', with: 'anerlo@gmail.com'
    fill_in 'user_password', with: '123123'
    click_on 'Log in'
    sleep(3)
    fill_in 'post_content', with: 'Lorena post!'
    click_on 'Save'
    sleep(3)
    click_on 'Sign out'
    visit root_path
    fill_in 'user_email', with: 'josiasjag@gmail.com'
    fill_in 'user_password', with: '123123'
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Lorena post!')
  end

  scenario 'User is not able to see its non-friend\'s posts' do
    visit root_path
    fill_in 'user_email', with: non_friendee.email
    fill_in 'user_password', with: non_friendee.password
    click_on 'Log in'
    sleep(3)
    fill_in 'post_content', with: 'Gloria post!'
    click_on 'Save'
    sleep(3)
    click_on 'Sign out'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    sleep(3)
    visit root_path
    sleep(3)
    expect(page).to_not have_content('Gloria post!')
  end
end
