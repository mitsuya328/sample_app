require 'rails_helper'

RSpec.feature "Signup", type: :system do
  context "with invalid information" do
    it "does not add a user" do
      visit signup_path
      expect(page).to have_selector 'form[action="/signup"]'
      fill_in "Name",         with: ""
      fill_in "Email",        with: "user@invalid"
      fill_in "Password",     with: "foo"
      fill_in "Password confirmation", with: "bar"
      expect { click_button "Create my account" }.not_to change(User, :count)
      expect(current_path).to eq signup_path
      expect(page).to have_selector 'div#error_explanation'
    end
  end

  context "with valid information" do
    it "add a user" do
      visit signup_path
      fill_in "Name",         with: "Example User"
      fill_in "Email",        with: "user@example.com"
      fill_in "Password",     with: "password"
      fill_in "Password confirmation", with: "password"
      expect { click_button "Create my account" }.to change(User, :count).by(1)
      expect(page).to have_selector '.alert'
      #expect(page).to have_content "Example User"
    end
  end
end
