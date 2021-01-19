require 'rails_helper'

describe 'Friendship', type: :feature do
  before :each do
    User.create(name: 'alan', email: 'alan@alan.com', password: 'acambaro')
    User.create(name: 'jeny', email: 'jeny@jeny.com', password: 'acambaro')
    visit '/users/sign_in'
    fill_in 'user_email', with: 'alan@alan.com'
    fill_in 'user_password', with: 'acambaro'
    find("input[type='submit']").click
  end

  it 'Add friend button' do
    visit '/users'
    click_on('Add friend')
    click_on('Sign out')
    fill_in 'user_email', with: 'jeny@jeny.com'
    fill_in 'user_password', with: 'acambaro'
    find("input[type='submit']").click
    visit '/users'
    section = find_by_id('friend_requests')
    expect(section).to have_text('alan')
  end

  it 'Avoid send invitation back, when invitation is already received' do
    visit '/users'
    click_on('Add friend')
    click_on('Sign out')
    fill_in 'user_email', with: 'jeny@jeny.com'
    fill_in 'user_password', with: 'acambaro'
    find("input[type='submit']").click
    visit '/users'
    section = find_by_id('user_alan')
    expect(section).not_to have_text('Add friend')
  end

  it 'Accept button' do
    visit '/users'
    click_on('Add friend')
    click_on('Sign out')
    fill_in 'user_email', with: 'jeny@jeny.com'
    fill_in 'user_password', with: 'acambaro'
    find("input[type='submit']").click
    visit '/users'
    click_on('Accept')

    click_on('Sign out')
    fill_in 'user_email', with: 'alan@alan.com'
    fill_in 'user_password', with: 'acambaro'
    find("input[type='submit']").click
    visit '/users'
    section = find_by_id('user_jeny')
    expect(section).not_to have_text('Add friend')
  end

  it 'Reject button' do
    visit '/users'
    click_on('Add friend')
    click_on('Sign out')
    fill_in 'user_email', with: 'jeny@jeny.com'
    fill_in 'user_password', with: 'acambaro'
    find("input[type='submit']").click
    visit '/users'
    click_on('Reject')
    section = find_by_id('user_alan')
    expect(section).to have_text('Add friend')
  end
end
