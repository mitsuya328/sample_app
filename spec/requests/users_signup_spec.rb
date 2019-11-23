require 'rails_helper'

describe "Signup", type: :request do
  before { ActionMailer::Base.deliveries.clear }

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

  context "with valid information and account activation" do
    it "add a user" do
      expect{
        post users_path, params: { user: { name:  "Example User",
                           email: "user@example.com",
                           password:              "password",
                           password_confirmation: "password" } }
      }.to change(User, :count).by(1)
      expect(ActionMailer::Base.deliveries.size).to eq 1
      user = assigns(:user)
      expect(user.activated?).to be_falsey
      # 有効化していない状態でログインしてみる
      log_in_as(user)
      expect(is_logged_in?).to be_falsey
      # トークンは正しいがメールアドレスが無効な場合
      get edit_account_activation_path(user.activation_token, email: 'wrong')
      expect(is_logged_in?).to be_falsey
      # 有効化トークンが正しい場合
      get edit_account_activation_path(user.activation_token, email: user.email)
      expect(user.reload.activated?).to be_truthy
      expect(is_logged_in?).to be_truthy
    end
  end
end
