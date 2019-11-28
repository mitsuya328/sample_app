require 'rails_helper'

RSpec.describe "UsersLogin", type: :system do
  before do
      @user = FactoryBot.create(:michael)
  end

  it 'with valid information followed by logout' do
    visit login_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(page).to have_content @user.name
    expect(page).not_to have_link href: login_path
    expect(page).to have_link href: logout_path, visible: false
    expect(page).to have_link href: user_path(@user), visible: false
    click_link 'Account'
    click_link 'Log out'
    expect(page).to have_content 'Sign up now!'
    expect(page).to have_link href: login_path
    expect(page).not_to have_link href: logout_path, visible: false
    expect(page).not_to have_link href: user_path(@user), visible: false
  end
end
