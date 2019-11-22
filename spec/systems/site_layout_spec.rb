require 'spec_helper'

RSpec.feature "SiteLayout", type: :system do

  subject { page }
  let(:user) { FactoryBot.create(:michael) }

  describe "home page when not logged in" do
    before { visit root_path }

    it { should have_link href: root_path, count: 2 }
    it { should have_link href: help_path }
    it { should have_link href: about_path }
    it { should have_link href: contact_path }
  end

  describe "home page when logged in" do
    before do
      log_in_as(user)
      visit root_path
    end

    it { should have_link href: root_path, count: 2 }
    it { should have_link href: help_path }
    it { should have_link href: about_path }
    it { should have_link href: contact_path }
    it { should have_link href: users_path }
    it { should have_link href: user_path(user), visible: false }
    it { should have_link href: edit_user_path(user), visible: false }
    it { should have_link href: logout_path, visible: false }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_title full_title("Sign up") }
  end
end
