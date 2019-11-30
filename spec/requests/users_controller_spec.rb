require 'rails_helper'

describe 'UsersController', type: :request do
  let!(:user) { FactoryBot.create(:michael) }
  let!(:other_user) { FactoryBot.create(:archer) }
  before(:all) { 30.times { FactoryBot.create(:user) } }
  after(:all)  { User.delete_all }

  context "when not logged in" do
    it "should redirect index" do
      get users_path
      expect(response).to redirect_to login_url
    end
  end

  it 'should get new' do
    get signup_path
    expect(response).to have_http_status(:success)
  end

  context "when not logged in" do
    it "should redirect edit" do
      get edit_user_path(user)
      expect(flash).not_to be_empty
      expect(response).to redirect_to login_url
    end

    it "should redirect update" do
      patch user_path(user), params: {user: {name: user.name,
                                      email: user.email}}
      expect(flash).not_to be_empty
      expect(response).to redirect_to login_url
    end

    it "should redirect destroy" do
      expect{ delete user_path(user) }.not_to change{ User.count }
      expect(response).to redirect_to login_url
    end

    it "should redirect following" do
      get following_user_path(user)
      expect(response).to redirect_to login_url
    end

    it "should redirect followers" do
      get followers_user_path(user)
      expect(response).to redirect_to login_url
    end
  end

  it "should not allow admin attribute to be edited via the web" do
    log_in_as(other_user)
    expect(other_user.admin).to be_falsey
    patch user_path(other_user), params: {
                                    user: { password:              other_user.password,
                                            password_confirmation: other_user.password,
                                            admin: true } }
    expect(other_user.reload.admin).to be_falsey
  end

  context "when logged in as wrong user" do
    before { log_in_as(other_user) }
    it "should redirect edit" do
      get edit_user_path(user)
      expect(flash).to be_empty
      expect(response).to redirect_to root_url
    end

    it "should redirect update" do
      patch user_path(user), params: { user: { name: user.name,
                                              email: user.email } }
      expect(flash).to be_empty
      expect(response).to redirect_to root_url
    end

    it "should redirect destroy" do
      expect{ delete user_path(user) }.not_to change{ User.count }
      expect(response).to redirect_to root_url
    end
  end
end
