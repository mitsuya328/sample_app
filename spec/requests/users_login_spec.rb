require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  before do
      @user = FactoryBot.create(:user)
  end

  it "with invalid information" do
    get login_path
    expect(response).to render_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    expect(response).to render_template 'sessions/new'
    expect(flash).to be_present
    get root_path
    expect(flash).not_to be_present
  end

  it "with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: @user.password } }
    expect(is_logged_in?).to be true
    delete logout_path
    delete logout_path
    expect(is_logged_in?).to be false
  end

  it "with remembering" do
    log_in_as(@user, remember_me: '1')
    expect(cookies['remember_token']).to be_present
  end

  it "without remembering" do
    # クッキーを保存してログイン
    log_in_as(@user, remember_me: '1')
    delete logout_path
    # クッキーを削除してログイン
    log_in_as(@user, remember_me: '0')
    expect(cookies['remember_token']).to be_empty
  end
end
