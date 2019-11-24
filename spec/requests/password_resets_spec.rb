require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  before { ActionMailer::Base.deliveries.clear }
  let(:user) { FactoryBot.create(:michael) }

  it "password resets" do
    get new_password_reset_path
    expect(response).to have_http_status(200)
    # メールアドレスが無効
    post password_resets_path, params: { password_reset: { email: ""}}
    expect(flash).not_to be_empty
    expect(response).to render_template 'new'
    # メールアドレスが有効
    post password_resets_path, params: { password_reset: { email: user.email } }
    expect(user.reset_digest).not_to eq user.reload.reset_digest
    expect(ActionMailer::Base.deliveries.size).to eq 1
    expect(flash).not_to be_empty
    expect(response).to redirect_to root_url
    # パスワード再設定フォームのテスト
    user = assigns(:user)
    # メールアドレスが無効
    get edit_password_reset_path(user.reset_token, email: "")
    expect(response).to redirect_to root_url
    # 無効なユーザー
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    expect(response).to redirect_to root_url
    user.toggle!(:activated)
    # メールアドレスが有効で、トークンが無効
    get edit_password_reset_path('wrong token', email:user.email)
    expect(response).to redirect_to root_url
    # メールアドレスもトークンも有効
    get edit_password_reset_path(user.reset_token, email: user.email)
    expect(response).to render_template 'password_resets/edit'
    # 無効なパスワードとパスワード確認
    patch password_reset_path(user.reset_token),
      params: { email: user.email,
                user: { password:              "foobaz",
                        password_confirmation: "barquux" }}
    expect(is_logged_in?).to be_falsey
    # パスワードが空
    patch password_reset_path(user.reset_token),
      params: { email: user.email,
                user: { password:              "",
                        password_confirmation: "" } }
    expect(is_logged_in?).to be_falsey
    # 有効なパスワードとパスワード確認
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password:              "foobaz",
                            password_confirmation: "foobaz" } }
    expect(is_logged_in?).to be_truthy
    expect(user.reload.reset_digest).to eq nil
    expect(flash).not_to be_empty
    expect(response).to redirect_to user
  end

  it "expired token" do
    post password_resets_path,
         params: { password_reset: { email: user.email } }
    @user = assigns(:user)
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(@user.reset_token),
         params: { email: @user.email,
                   user: { password:              "foobar",
                           password_confirmation: "foobar" } }
    expect(response).to redirect_to password_resets_url
  end
end
