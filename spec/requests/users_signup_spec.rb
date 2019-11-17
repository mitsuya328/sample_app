require 'rails_helper'

describe "Signup", type: :request do
  context "with invalid information" do
    it "does not add a user" do
      expect{
        post signup_path, params: { user: { name:  "",
                           email: "user@invalid",
                           password:              "foo",
                           password_confirmation: "bar" } }
      }.not_to change(User, :count)
      expect(response).to render_template 'users/new'
    end
  end

  context "with valid information" do
    it "add a user" do
      expect{
        post signup_path, params: { user: { name:  "Example User",
                           email: "user@example.com",
                           password:              "password",
                           password_confirmation: "password" } }
      }.to change(User, :count).by(1)
      #expect(response).to render_template('users/show')
    end
  end
end
