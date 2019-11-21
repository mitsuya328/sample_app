require 'rails_helper'

describe 'UsersController', type: :request do
  let(:user) { FactoryBot.create(:michael) }
  let(:other_user) { FactoryBot.create(:archer) }

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
  end
end
