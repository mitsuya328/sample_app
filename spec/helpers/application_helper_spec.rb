require 'spec_helper'

describe 'ApplicationHelper' do

  describe "full_title" do
    it "should not include a bar for the home page" do
      expect(full_title).not_to match(/\|/)
    end

    it "should include the page title" do
      expect(full_title("Help")).to match(/Help \| Ruby on Rails Tutorial Sample App/)
    end
  end
end
