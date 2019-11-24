require 'rails_helper'

RSpec.describe "UsersProgiles", type: :system do
  let(:user){ FactoryBot.create(:michael) }
  describe "profile display" do
    subject {page}

    before{ visit user_path(user) }

    it{ is_expected.to have_title full_title(user.name) }
  end
end
