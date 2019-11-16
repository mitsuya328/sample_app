require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_title 'Ruby on Rails Tutorial Sample App' }
    it { should_not have_title 'Home' }
  end

  describe "Help page" do
    before { visit static_pages_help_url }
    it { should have_title 'Help | Ruby on Rails Tutorial Sample App' }
  end

  describe "About page" do
    before { visit static_pages_about_url }
    it { should have_title 'About | Ruby on Rails Tutorial Sample App' }
  end

  describe "Contact page" do
    before { visit static_pages_contact_url }
    it { should have_title 'Contact | Ruby on Rails Tutorial Sample App' }
  end
end
