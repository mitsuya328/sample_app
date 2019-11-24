require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let!(:user){ FactoryBot.create(:michael) }
  let!(:micropost){ FactoryBot.create(:orange, user: user) }
  let!(:tau_manifesto){ FactoryBot.create(:tau_manifesto, user: user) }
  let!(:cat_video){ FactoryBot.create(:cat_video, user: user) }
  let!(:most_recent){ FactoryBot.create(:most_recent, user: user) }

  it "is valid" do
    expect(micropost).to be_valid
  end

  it "have user id" do
    micropost.user_id = nil
    expect(micropost).not_to be_valid
  end

  it "have content" do
    micropost.content = " "
    expect(micropost).not_to be_valid
  end

  it "have content at most 140 characters" do
    micropost.content = "a" * 141
    expect(micropost).not_to be_valid
  end

  it "order should be most recent first" do
    expect(Micropost.first).to eq most_recent
  end
end
