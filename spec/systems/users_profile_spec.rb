require 'rails_helper'

RSpec.describe "UsersProgiles", type: :system do
  before do
    @user = FactoryBot.create(:michael)
    50.times { FactoryBot.create(:post, user: @user) }
  end
  after  { Micropost.delete_all }

  describe "profile display" do
    subject {page}

    before{ visit user_path(@user) }

    it{ is_expected.to have_title full_title(@user.name) }
    it{ is_expected.to have_selector 'h1', text: @user.name }
    it{ is_expected.to have_selector 'h1>img.gravatar' }
    it{ is_expected.to have_content @user.microposts.count.to_s }
    it{ is_expected.to have_selector 'div.pagination' }
    it "microposts" do
      @user.microposts.paginate(page: 1).each do |micropost|
        expect(page).to have_content micropost.content
      end
    end
  end
end
