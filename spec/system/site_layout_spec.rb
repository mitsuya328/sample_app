require 'spec_helper'

describe "SiteLayoutTest" do

  subject { page }

  describe "layout links" do
    before { visit root_path }

    it { should have_link href: root_path, count: 2 }
    it { should have_link href: help_path }
    it { should have_link href: about_path }
    it { should have_link href: contact_path }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_title full_title("Sign up") }
  end
end
