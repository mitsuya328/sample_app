require 'rails_helper'

describe 'StaticPagesController', type: :system do

  it 'should get home' do
    visit static_pages_home_url
    expect(page).to have_title "Home | Ruby on Rails Tutorial Sample App"
  end

  it 'should get help' do
    visit static_pages_help_url
    expect(page).to have_title "Help | Ruby on Rails Tutorial Sample App"
  end

  it 'should get about' do
    visit static_pages_about_url
    expect(page).to have_title "About | Ruby on Rails Tutorial Sample App"
  end

  it 'should get contact' do
    visit static_pages_contact_url
    expect(page).to have_title "Contact | Ruby on Rails Tutorial Sample App"
  end
end
