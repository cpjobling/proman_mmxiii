require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit new_user_registration_path }

    page!

    it { should have_selector('h2',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end
end