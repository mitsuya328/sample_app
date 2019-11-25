require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  let!(:user){ FactoryBot.create(:michael) }
  let!(:micropost){ FactoryBot.create(:orange, user: user) }

  it "should redirect create when not logged in" do
    expect{
      post microposts_path, params: {micropost: {content: "Lorem ipsum"}}
    }.not_to change{ Micropost.count}
    expect(response).to redirect_to login_url
  end

  it "should redirect destroy when not logged in" do
    expect{
      delete micropost_path(micropost)
    }.not_to change{ Micropost.count}
    expect(response).to redirect_to login_url
  end

end
