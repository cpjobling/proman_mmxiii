require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "Proman 2013" }
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h2',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end
  
  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'Proman' }
    let(:page_title) { '' }
    it_should_behave_like "all static pages"
    it { should_not have_selector('title', text: full_title('Home')) }
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { heading }
    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading) { 'About Proman' }
    let(:page_title) { heading }
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading) { 'Contact Us' }
    let(:page_title) { heading }
    it_should_behave_like "all static pages"
  end

  describe "Terms of Service page" do
    before { visit tos_path }
    let(:heading) { 'Terms of Service' }
    let(:page_title) { heading }
    it_should_behave_like "all static pages"
  end

  describe "License" do
    before { visit license_path }
    let(:heading) { 'Software License' }
    let(:page_title) { heading }
    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      page.should have_selector 'title', text: full_title('About Proman')
      click_link "Help"
      page.should have_selector 'title', text: full_title('Help')
      click_link "Contact"
      page.should have_selector 'title', text: full_title('Contact Us')
      click_link "Terms of Service"
      page.should have_selector 'title', text: full_title('Terms of Service')
      click_link "License"
      page.should have_selector 'title', text: full_title('Software License')
      click_link "Home"
      click_link "Sign up now!"
      page.should have_selector 'title', text: full_title('Sign up')
      click_link "Proman"
      page.should have_selector 'title', text: full_title('')
    end
end
