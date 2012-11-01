require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "Proman 2013" }
  
  describe "Home page" do

    it "should have the h1 'Proman'" do
      visit '/static_pages/home'
      page.should have_selector('h1', text: 'Proman')
    end

    it "should have the base title" do
      visit '/static_pages/home'
      page.should have_selector('title',
                    text: "#{base_title}")
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => '| Home')
    end

  end

  describe "Help page" do

    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', text: 'Help')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title',
                    text: "#{base_title} | Help")
    end

  end

  describe "About page" do

    it "should have the h1 'Abot Proman'" do
      visit '/static_pages/about'
      page.should have_selector('h1', text: 'About Proman')
    end

    it "should have the title 'About Proman'" do
      visit '/static_pages/about'
      page.should have_selector('title',
                    text: "#{base_title} | About Proman")
    end
  end

  describe "Contact page" do

    it "should have the h1 'Contact Us'" do
      visit '/static_pages/contact'
      page.should have_selector('h1', text: 'Contact Us')
    end

    it "should have the title 'Contact Us'" do
      visit '/static_pages/contact'
      page.should have_selector('title',
                    text: "#{base_title} | Contact Us")
    end
  end
end
