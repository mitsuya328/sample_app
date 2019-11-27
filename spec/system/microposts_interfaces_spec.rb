require 'rails_helper'

RSpec.describe "MicropostsInterface", type: :request do
  let(:user){ FactoryBot.create(:michael) }
  let(:other_user){ FactoryBot.create(:archer) }

  before do
    50.times { FactoryBot.create(:post, user: user) }
  end
  after  { Micropost.delete_all }

  it "micropost interface" do
    log_in_as(user)
    get root_path
    # 無効な送信
    expect{
      post microposts_path, params:{ micropost: { content: "" } }
    }.not_to change{ Micropost.count }
    expect(assigns(:micropost).errors).not_to eq nil
    # 有効な送信
    content = "This micropost really ties the room together"
    expect{
      post microposts_path, params:{ micropost: { content: content } }
    }.to change{ Micropost.count }.by(1)
    expect(response).to redirect_to root_url
    expect(Micropost.find_by(content: content)).not_to eq nil
    # 投稿を削除する
    first_micropost = user.microposts.paginate(page: 1).first
    expect{
      delete micropost_path(first_micropost)
    }.to change{ Micropost.count }.by(-1)
  end

  it "micropost sidebar count" do
    log_in_as(user)
    get root_path
    expect(response.body).to include "#{user.microposts.count} microposts"
    # まだマイクロポストを投稿していないユーザー
    log_in_as(other_user)
    get root_path
    expect(response.body).to include "0 microposts"
    other_user.microposts.create!(content: "A micropost")
    get root_path
    expect(response.body).to include "1 micropost"
  end
end
